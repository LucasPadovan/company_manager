class ProductHistoriesController < ApplicationController
  before_filter :get_product
  before_filter :get_firm, only: [:index, :new]

  def index
    @product_histories = @product.product_histories.order('date desc').page(params[:page])
    @title = t('view.product_histories.index_title', product: @product.name, firm: @firm.nombre)
    if params[:firm].present?
      @product_histories = @product_histories.where(firm_id: params[:firm])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_histories }
    end
  end

  def show
    @product_history = ProductHistory.find(params[:id])
    @title = t('view.product_histories.show_title')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_history }
    end
  end

  def new
    @product_history = @product.product_histories.build
    @title = ( @firm.present? ?
               t('view.product_histories.new_title_firm', product: @product.name, firm: @firm.nombre) :
               t('view.product_histories.new_title', product: @product.name)
             )
    if params[:firm].present?
      @product_history.firm_id = params[:firm]
    end

    render partial: 'form', content_type: 'text/html'
  end

  def create
    @product_history = @product.product_histories.build(params[:product_history])
    @product_history.user = @current_user
    @title = if @firm.present?
               t('view.product_histories.new_title_firm', product: @product.name, firm: @firm.nombre)
             else
               t('view.product_histories.new_title', product: @product.name)
             end


    if @product_history.save
      render partial: 'product_history', locals: { product_history: @product_history }, content_type: 'text/html'
    else
      render partial: 'form', status: :unprocessable_entity
    end
  end

  private
    def get_product
      @product = Product.find(params[:product_id])
    end

    def get_firm
      @firm = Firm.find(params[:firm]) if params[:firm]
    end
end
