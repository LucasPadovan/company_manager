class SaleHistoriesController < ApplicationController
  before_filter :get_product

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

  def show
    @title = t('view.sale_histories.show_title')
    @sale_history = SaleHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sale_history }
    end
  end

  def new
    @sale_history = @product.sale_histories.build
    @title = t('view.sale_histories.new_title', product: @product.name)
    if params[:firm].present?
      @sale_history.firm_id = params[:firm]
    end

    render partial: 'form', content_type: 'text/html'
  end

  def create
    @sale_history = @product.sale_histories.build(params[:sale_history])
    @title = t('view.sale_histories.new_title', product: @product.name)

    if @sale_history.save
      render partial: 'sale_history', locals: { sale_history: @sale_history}, content_type: 'text/html'
    else
      render partial: 'form', status: :unprocessable_entity
    end
  end

  private
  def get_product
    @product = Product.find(params[:product_id])
  end
end
