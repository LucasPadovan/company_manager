class ProductsController < ApplicationController
  
  def index
    @title = t('view.products.index_title')
    @products = Product.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @product = Product.includes(:product_histories, :sale_histories).find(params[:id])
    @title = t('view.products.show_title', product: @product.name)
    @product_histories = []
    Firm.joins(:product_histories).select('DISTINCT firms.*').each do |firm|
      @product_histories << firm.product_histories.order(:date).last
    end
    @sale_histories = []
    Firm.joins(:sale_histories).select('DISTINCT firms.*').each do |firm|
      @sale_histories << firm.sale_histories.order(:date).last
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new
    @title = t('view.products.new_title')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
    @title = t('view.products.edit_title', product: @product.name)
  end

  def create
    @product = Product.new(params[:product])
    @title = t('view.products.new_title')
    @product.user = @current_user

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: t('view.products.correctly_created') }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    @title = t('view.products.edit_title')

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: t('view.products.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_product_url(@product), alert: t('view.products.stale_object_error')
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :ok }
    end
  end
end
