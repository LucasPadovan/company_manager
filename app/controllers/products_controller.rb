class ProductsController < ApplicationController

  def index
    @title = t('view.products.index_title')
    if params[:type].present?
      case params[:type]
        when 'CustomProduct'  then @products = CustomProduct.page(params[:page])
        when 'RawMaterial'    then @products = RawMaterial.page(params[:page])
        else                  @products = Product.page(params[:page])
      end
    else
      @products = Product.page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @product = Product.includes(:purchase_interests, :sale_interests).find(params[:id])
    @title = t('view.products.show_title', product: @product.name)
    @purchase_interests = @product.purchase_interests
    @sale_interests = @product.sale_interests

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new
    @title = t('view.products.new_title')

    render partial: 'new', content_type: 'text/html'
  end

  def edit
    @product = Product.find(params[:id])
    @title = t('view.products.edit_title', product: @product.name)

    render partial: 'edit', content_type: 'text/html'
  end

  def create
    @product = Product.new(params[:product])
    @title = t('view.products.new_title')
    @product.user = @current_user

    if @product.save
      render partial: 'product', locals: { product: @product }, content_type: 'text/html'
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])
    @title = t('view.products.edit_title')

    if @product.update_attributes(params[:product])
      render partial: 'product', locals: { product: Product.find(params[:id]) }, content_type: 'text/html'
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  rescue ActiveRecord::StaleObjectError
    js_redirect to: edit_product_url(@product)
    js_notify message: t('view.products.stale_object_error')
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      render nothing: true, content_type: 'text/html'
    else
      render nothing: true
    end
  end
end
