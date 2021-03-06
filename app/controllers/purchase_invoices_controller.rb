class PurchaseInvoicesController < ApplicationController
  before_filter :get_monthly_movement

  def index
    @title = t('view.purchase_invoices.index_title', month: @monthly_movement.month, year: @monthly_movement.year)
    @totals = {ventas: 0, consumo: 0, iva: 0, retencion: 0, other_concepts: 0, total: 0 }
    if params[:firm].present?
      @purchase_invoices = @monthly_movement.purchase_invoices.where('firms.nombre LIKE ?', "%#{params[:firm]}%")
    else
      @purchase_invoices = @monthly_movement.purchase_invoices
    end

    @purchase_invoices = @purchase_invoices.includes(:firm).order('date asc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchase_invoices }
    end
  end

  def show
    @title = t('view.purchase_invoices.show_title')
    @purchase_invoice = PurchaseInvoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase_invoice }
    end
  end

  def new
    @purchase_invoice = @monthly_movement.purchase_invoices.build
    @title = t('view.purchase_invoices.new_title', month:@monthly_movement.month, year: @monthly_movement.year)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase_invoice }
    end
  end

  def edit
    @purchase_invoice = PurchaseInvoice.includes(:firm).find(params[:id])
    @title = t('view.purchase_invoices.edit_title', date: @purchase_invoice.date.strftime('%d/%m/%y'), firm: @purchase_invoice.firm.name)
  end

  def create
    @purchase_invoice = @monthly_movement.purchase_invoices.build(params[:purchase_invoice])
    @purchase_invoice.date = "#{params[:purchase_invoice][:date].to_i + 1}/#{MonthlyMovement::MONTHS[@monthly_movement.month.to_sym]}/#{@monthly_movement.year}".to_datetime
    @title = t('view.purchase_invoices.new_title', month:@monthly_movement.month, year: @monthly_movement.year)

    respond_to do |format|
      if @purchase_invoice.save
        format.html { redirect_to monthly_movement_purchase_invoices_path(@monthly_movement), notice: t('view.purchase_invoices.correctly_created') }
        format.json { render json: monthly_movement_purchase_invoices_path(@monthly_movement), status: :created, location: [@monthly_movement, @purchase_invoice] }
      else
        format.html { render action: 'new' }
        format.json { render json: @purchase_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @purchase_invoice = PurchaseInvoice.find(params[:id])
    @title = t('view.purchase_invoices.edit_title', date: @purchase_invoice.date.strftime('%d/%m/%y'), firm: @purchase_invoice.firm.name)
    params[:purchase_invoice][:date] = "#{params[:purchase_invoice][:date].to_i + 1}/#{MonthlyMovement::MONTHS[@monthly_movement.month.to_sym]}/#{@monthly_movement.year}".to_datetime

    respond_to do |format|
      if @purchase_invoice.update_attributes(params[:purchase_invoice])
        format.html { redirect_to monthly_movement_purchase_invoices_path(@monthly_movement), notice: t('view.purchase_invoices.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @purchase_invoice.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_monthly_movement_purchase_invoice_url(@purchase_invoice), alert: t('view.purchase_invoices.stale_object_error')
  end

  def destroy
    @purchase_invoice = PurchaseInvoice.find(params[:id])
    @purchase_invoice.destroy

    respond_to do |format|
      format.html { redirect_to monthly_movement_purchase_invoices_url }
      format.json { head :ok }
    end
  end

  def generate_csv
    @purchase_invoices = @monthly_movement.purchase_invoices
    send_data @purchase_invoices.order(:date).inject(['Fecha', 'Numero', 'Empresa','CUIT','Ventas','Consumo', 'IVA','Retencion', 'Importe no gravado','Total'].to_csv) { |file,row| file << row.to_csv },
              type: 'text/csv; charset=utf-8; header=present',
              filename: "Facturas_Compra_#{@monthly_movement.month}/#{@monthly_movement.year}.csv"
  end

  protected
    def get_monthly_movement
      @monthly_movement = MonthlyMovement.find(params[:monthly_movement_id])
    end
end
