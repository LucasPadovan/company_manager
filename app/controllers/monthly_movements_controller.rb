class MonthlyMovementsController < ApplicationController
  
  # GET /monthly_movements
  # GET /monthly_movements.json
  def index
    @title = t('view.monthly_movements.index_title')
    @monthly_movements = MonthlyMovement.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @monthly_movements }
    end
  end

  # GET /monthly_movements/1
  # GET /monthly_movements/1.json
  def show
    @monthly_movement = MonthlyMovement.find(params[:id])
    @title = t('view.monthly_movements.show_title', month: @monthly_movement.month, year: @monthly_movement.year)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @monthly_movement }
    end
  end

  # GET /monthly_movements/new
  # GET /monthly_movements/new.json
  def new
    @title = t('view.monthly_movements.new_title')
    @monthly_movement = @current_user.monthly_movements.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @monthly_movement }
    end
  end

  # GET /monthly_movements/1/edit
  def edit
    @monthly_movement = MonthlyMovement.find(params[:id])
    @title = t('view.monthly_movements.edit_title', month: @monthly_movement.month)
  end

  # POST /monthly_movements
  # POST /monthly_movements.json
  def create
    @title = t('view.monthly_movements.new_title')
    @monthly_movement = @current_user.monthly_movements.build(params[:monthly_movement])

    respond_to do |format|
      if @monthly_movement.save
        format.html { redirect_to @monthly_movement, notice: t('view.monthly_movements.correctly_created') }
        format.json { render json: @monthly_movement, status: :created, location: @monthly_movement }
      else
        format.html { render action: 'new' }
        format.json { render json: @monthly_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /monthly_movements/1
  # PUT /monthly_movements/1.json
  def update
    @title = t('view.monthly_movements.edit_title')
    @monthly_movement = MonthlyMovement.find(params[:id])

    respond_to do |format|
      if @monthly_movement.update_attributes(params[:monthly_movement])
        format.html { redirect_to @monthly_movement, notice: t('view.monthly_movements.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @monthly_movement.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_monthly_movement_url(@monthly_movement), alert: t('view.monthly_movements.stale_object_error')
  end

  def set_as_send
    #todo: mandar al modelo.
    @monthly_movement = MonthlyMovement.find(params[:id])
    p_subtotal = @monthly_movement.purchase_invoices.sum(&:subtotal)
    p_iva_total = @monthly_movement.purchase_invoices.sum(&:iva)
    p_other = @monthly_movement.purchase_invoices.sum(&:other_concepts) + @monthly_movement.purchase_invoices.sum(&:retencion)
    p_total = @monthly_movement.purchase_invoices.sum(&:total)
    s_subtotal = @monthly_movement.sale_invoices.sum(&:subtotal)
    s_iva_total = @monthly_movement.sale_invoices.sum(&:iva)
    s_other = @monthly_movement.sale_invoices.sum(&:other_concepts) + @monthly_movement.sale_invoices.sum(&:retencion)
    s_total = @monthly_movement.sale_invoices.sum(&:total)
    @monthly_movement.update_attributes(status: MonthlyMovement::STATUSES[1],
                                        purchases_subtotal: p_subtotal, purchases_iva_total: p_iva_total, purchases_otros_conc_total: p_other, purchases_total: p_total,
                                        sales_subtotal: s_subtotal, sales_iva_total: s_iva_total, sales_otros_conc_total: s_other, sales_total: s_total)
    redirect_to :back
  end

  def set_as_finalized
    @monthly_movement = MonthlyMovement.find(params[:id])
    @monthly_movement.update_attributes(status: MonthlyMovement::STATUSES[2])
    redirect_to :back
  end
end
