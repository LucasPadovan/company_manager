class SaleInovicesController < ApplicationController
  before_filter :get_monthly_movement

  # GET /sale_inovices
  # GET /sale_inovices.json
  def index
    @title = t('view.sale_inovices.index_title')
    @totals = {ventas: 0, consumo: 0, iva: 0, retencion: 0, other_concepts: 0, total: 0 }
    if params[:firm].present?
      @sale_inovices = @monthly_movement.purchase_invoices.where('firms.nombre LIKE ?', "%#{params[:firm]}%")
    else
      @sale_inovices = @monthly_movement.purchase_invoices
    end

    @sale_inovices = @sale_inovices.includes(:firm).order('date asc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sale_inovices }
    end
  end

  # GET /sale_inovices/1
  # GET /sale_inovices/1.json
  def show
    @title = t('view.sale_inovices.show_title')
    @sale_inovice = SaleInovice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sale_inovice }
    end
  end

  # GET /sale_inovices/new
  # GET /sale_inovices/new.json
  def new
    @title = t('view.sale_inovices.new_title')
    @sale_inovice = @monthly_movement.sale_invoices.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sale_inovice }
    end
  end

  # GET /sale_inovices/1/edit
  def edit
    @title = t('view.sale_inovices.edit_title')
    @sale_inovice = SaleInovice.find(params[:id])
  end

  # POST /sale_inovices
  # POST /sale_inovices.json
  def create
    @title = t('view.sale_inovices.new_title')
    @sale_invoice = @monthly_movement.sale_invoices.build(params[:sale_invoice])
    @sale_invoice.date = "#{params[:sale_invoice][:date].to_i + 1}/#{MonthlyMovement::MONTHS[@monthly_movement.month.to_sym]}/#{@monthly_movement.year}".to_datetime

    respond_to do |format|
      if @sale_inovice.save
        format.html { redirect_to monthly_movement_sale_invoices_path(@monthly_movement), notice: t('view.sale_inovices.correctly_created') }
        format.json { render json: monthly_movement_sale_invoices_path(@monthly_movement), status: :created, location: @sale_inovice }
      else
        format.html { render action: 'new' }
        format.json { render json: @sale_inovice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sale_inovices/1
  # PUT /sale_inovices/1.json
  def update
    @title = t('view.sale_inovices.edit_title')
    @sale_inovice = SaleInovice.find(params[:id])

    respond_to do |format|
      if @sale_inovice.update_attributes(params[:sale_inovice])
        format.html { redirect_to monthly_movement_sale_invoices_path(@monthly_movement), notice: t('view.sale_inovices.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sale_inovice.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_sale_inovice_url(@sale_inovice), alert: t('view.sale_inovices.stale_object_error')
  end

  # DELETE /sale_inovices/1
  # DELETE /sale_inovices/1.json
  def destroy
    @sale_inovice = SaleInovice.find(params[:id])
    @sale_inovice.destroy

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
