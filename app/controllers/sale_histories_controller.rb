class SaleHistoriesController < ApplicationController
  before_filter :get_product

  # GET /sale_histories
  # GET /sale_histories.json
  def index
    @sale_histories = @product.sale_histories.order('date desc').page(params[:page])
    @title = t('view.sale_histories.index_title', product: @product.name)
    if params[:firm].present?
      @sale_histories = @sale_histories.where(firm_id: params[:firm])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sale_histories }
    end
  end

  # GET /sale_histories/1
  # GET /sale_histories/1.json
  def show
    @title = t('view.sale_histories.show_title')
    @sale_history = SaleHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sale_history }
    end
  end

  # GET /sale_histories/new
  # GET /sale_histories/new.json
  def new
    @sale_history = @product.sale_histories.build
    @title = t('view.sale_histories.new_title', product: @product.name)
    if params[:firm].present?
      @sale_history.firm_id = params[:firm]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sale_history }
    end
  end

  # GET /sale_histories/1/edit
  def edit
    @sale_history = SaleHistory.includes(:product).find(params[:id])
    @title = t('view.sale_histories.edit_title', product: @sale_history.product.name)
  end

  # POST /sale_histories
  # POST /sale_histories.json
  def create
    @sale_history = @product.sale_histories.build(params[:sale_history])
    @title = t('view.sale_histories.new_title', product: @product.name)

    respond_to do |format|
      if @sale_history.save
        format.html { redirect_to @product, notice: t('view.sale_histories.correctly_created') }
        format.json { render json: @product, status: :created, location: @sale_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @sale_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sale_histories/1
  # PUT /sale_histories/1.json
  def update
    @sale_history = SaleHistory.includes(:product).find(params[:id])
    @title = t('view.sale_histories.edit_title', product: @sale_history.product.name)

    respond_to do |format|
      if @sale_history.update_attributes(params[:sale_history])
        format.html { redirect_to @sale_history, notice: t('view.sale_histories.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sale_history.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_sale_history_url(@sale_history), alert: t('view.sale_histories.stale_object_error')
  end

  # DELETE /sale_histories/1
  # DELETE /sale_histories/1.json
  def destroy
    @sale_history = SaleHistory.find(params[:id])
    @sale_history.destroy

    respond_to do |format|
      format.html { redirect_to product_sale_histories_path(@product) }
      format.json { head :ok }
    end
  end

  private
  def get_product
    @product = Product.find(params[:product_id])
  end
end
