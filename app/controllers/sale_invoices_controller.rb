class SaleInvoicesController < ApplicationController
  before_filter :get_monthly_movement

  # GET /sale_invoices
  # GET /sale_invoices.json
  def index
    @title = t('view.sale_invoices.index_title')
    @totals = {subtotal: 0, iva: 0, retencion: 0, other_concepts: 0, total: 0 }
    if params[:firm].present?
      @sale_invoices = @monthly_movement.sale_invoices.where('firms.nombre LIKE ?', "%#{params[:firm]}%")
    else
      @sale_invoices = @monthly_movement.sale_invoices
    end

    @sale_invoices = @sale_invoices.includes(:firm).order('date asc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sale_invoices }
    end
  end

  # GET /sale_invoices/1
  # GET /sale_invoices/1.json
  def show
    @title = t('view.sale_invoices.show_title')
    @sale_invoice = SaleInvoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sale_invoice }
    end
  end

  # GET /sale_invoices/new
  # GET /sale_invoices/new.json
  def new
    @title = t('view.sale_invoices.new_title')
    @sale_invoice = @monthly_movement.sale_invoices.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sale_invoice }
    end
  end

  # GET /sale_invoices/1/edit
  def edit
    @title = t('view.sale_invoices.edit_title')
    @sale_invoice = SaleInvoice.find(params[:id])
  end

  # POST /sale_invoices
  # POST /sale_invoices.json
  def create
    @title = t('view.sale_invoices.new_title')
    @sale_invoice = @monthly_movement.sale_invoices.build(params[:sale_invoice])
    @sale_invoice.date = "#{params[:sale_invoice][:date].to_i + 1}/#{MonthlyMovement::MONTHS[@monthly_movement.month.to_sym]}/#{@monthly_movement.year}".to_datetime

    respond_to do |format|
      if @sale_invoice.save
        format.html { redirect_to monthly_movement_sale_invoices_path(@monthly_movement), notice: t('view.sale_invoices.correctly_created') }
        format.json { render json: monthly_movement_sale_invoices_path(@monthly_movement), status: :created, location: @sale_invoice }
      else
        format.html { render action: 'new' }
        format.json { render json: @sale_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sale_invoices/1
  # PUT /sale_invoices/1.json
  def update
    @title = t('view.sale_invoices.edit_title')
    @sale_invoice = SaleInvoice.find(params[:id])

    respond_to do |format|
      if @sale_invoice.update_attributes(params[:sale_invoice])
        format.html { redirect_to monthly_movement_sale_invoices_path(@monthly_movement), notice: t('view.sale_invoices.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sale_invoice.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_sale_invoice_url(@sale_invoice), alert: t('view.sale_invoices.stale_object_error')
  end

  # DELETE /sale_invoices/1
  # DELETE /sale_invoices/1.json
  def destroy
    @sale_invoice = SaleInvoice.find(params[:id])
    @sale_invoice.destroy

    respond_to do |format|
      format.html { redirect_to monthly_movement_sale_invoices_url }
      format.json { head :ok }
    end
  end

  def generate_csv
    @sale_invoices = @monthly_movement.sale_invoices
    send_data @sale_invoices.inject(['Fecha', 'Numero', 'Empresa', 'CUIT', 'IVA', 'Subtotal', 'Retencion', 'Importe no gravado','Total'].to_csv) { |file,row| file << row.to_csv },
              type: 'text/csv; charset=utf-8; header=present',
              filename: "Facturas_Venta_#{@monthly_movement.month}/#{@monthly_movement.year}.csv"
  end

  protected
    def get_monthly_movement
      @monthly_movement = MonthlyMovement.find(params[:monthly_movement_id])
    end
end
