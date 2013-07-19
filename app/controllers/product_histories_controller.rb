class ProductHistoriesController < ApplicationController
  before_filter :get_product
  before_filter :get_firm, only: [:index, :new, :edit]

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
    @title = if @firm.present?
               t('view.product_histories.new_title_firm', product: @product.name, firm: @firm.nombre)
             else
               t('view.product_histories.new_title', product: @product.name)
             end

    if params[:firm].present?
      @product_history.firm_id = params[:firm]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_history }
    end
  end

  def edit
    @product_history = ProductHistory.find(params[:id])
    @title = t('view.product_histories.edit_title', product: @product.name, firm: @firm.nombre)
  end

  def create
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

  def update
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

    def get_firm
      @firm = Firm.find(params[:firm]) if params[:firm]
    end
end
