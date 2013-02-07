class PurchaseInvoicesController < ApplicationController
  before_filter :get_monthly_movement

  # GET /purchase_invoices
  # GET /purchase_invoices.json
  def index
    @title = t('view.purchase_invoices.index_title')
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

  # GET /purchase_invoices/1
  # GET /purchase_invoices/1.json
  def show
    @title = t('view.purchase_invoices.show_title')
    @purchase_invoice = PurchaseInvoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase_invoice }
    end
  end

  # GET /purchase_invoices/new
  # GET /purchase_invoices/new.json
  def new
    @title = t('view.purchase_invoices.new_title')
    @purchase_invoice = @monthly_movement.purchase_invoices.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase_invoice }
    end
  end

  # GET /purchase_invoices/1/edit
  def edit
    @title = t('view.purchase_invoices.edit_title')
    @purchase_invoice = PurchaseInvoice.find(params[:id])
  end

  # POST /purchase_invoices
  # POST /purchase_invoices.json
  def create
    @title = t('view.purchase_invoices.new_title')
    @purchase_invoice = @monthly_movement.purchase_invoices.build(params[:purchase_invoice])
    @purchase_invoice.date = "#{params[:purchase_invoice][:date]}/#{MonthlyMovement::MONTHS[@monthly_movement.month.to_sym]}/#{@monthly_movement.year}".to_datetime

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

  # PUT /purchase_invoices/1
  # PUT /purchase_invoices/1.json
  def update
    @title = t('view.purchase_invoices.edit_title')
    @purchase_invoice = PurchaseInvoice.find(params[:id])

    respond_to do |format|
      if @purchase_invoice.update_attributes(params[:purchase_invoice])
        format.html { redirect_to [@monthly_movement, @purchase_invoice], notice: t('view.purchase_invoices.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @purchase_invoice.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_monthly_movement_purchase_invoice_url(@purchase_invoice), alert: t('view.purchase_invoices.stale_object_error')
  end

  # DELETE /purchase_invoices/1
  # DELETE /purchase_invoices/1.json
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
    send_data @purchase_invoices.inject(['Fecha','Empresa','CUIT','Ventas','Consumo', 'IVA','Retencion', 'Importe no gravado','Total'].to_csv) { |file,row| file << row.to_csv },
              type: 'text/csv; charset=utf-8; header=present',
              filename: "Factura_Compras_#{@monthly_movement.month}/#{@monthly_movement.year}.csv"
  end

  protected
    def get_monthly_movement
      @monthly_movement = MonthlyMovement.find(params[:monthly_movement_id])
    end
end
