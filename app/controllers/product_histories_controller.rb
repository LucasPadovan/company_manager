class ProductHistoriesController < ApplicationController
  before_filter :get_product

  # GET /product_histories
  # GET /product_histories.json
  def index
    @title = t('view.product_histories.index_title')
    @product_histories = @product.product_histories.order('date desc').page(params[:page])
    if params[:firm].present?
      @product_histories = @product_histories.where(firm_id: params[:firm])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_histories }
    end
  end

  # GET /product_histories/1
  # GET /product_histories/1.json
  def show
    @title = t('view.product_histories.show_title')
    @product_history = ProductHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_history }
    end
  end

  # GET /product_histories/new
  # GET /product_histories/new.json
  def new
    @title = t('view.product_histories.new_title')
    @product_history = @product.product_histories.build
    if params[:firm].present?
      @product_history.firm_id = params[:firm]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_history }
    end
  end

  # GET /product_histories/1/edit
  def edit
    @title = t('view.product_histories.edit_title')
    @product_history = ProductHistory.find(params[:id])
  end

  # POST /product_histories
  # POST /product_histories.json
  def create
    @title = t('view.product_histories.new_title')
    @product_history = @product.product_histories.build(params[:product_history])
    @product_history.user = @current_user

    respond_to do |format|
      if @product_history.save
        format.html { redirect_to @product, notice: t('view.product_histories.correctly_created') }
        format.json { render json: @product, status: :created, location: @product_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_histories/1
  # PUT /product_histories/1.json
  def update
    @title = t('view.product_histories.edit_title')
    @product_history = ProductHistory.find(params[:id])

    respond_to do |format|
      if @product_history.update_attributes(params[:product_history])
        format.html { redirect_to product_product_histories_path(@product), notice: t('view.product_histories.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_history.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_product_product_history_url(@product, @product_history), alert: t('view.product_histories.stale_object_error')
  end

  # DELETE /product_histories/1
  # DELETE /product_histories/1.json
  def destroy
    @product_history = ProductHistory.find(params[:id])
    @product_history.destroy

    respond_to do |format|
      format.html { redirect_to product_product_histories_url(@product) }
      format.json { head :ok }
    end
  end

  private
    def get_product
      @product = Product.find(params[:product_id])
    end
end