class PricesController < ApplicationController
  before_filter :get_interest
  before_filter :get_firm, only: [:index, :new]

  def index
    @prices = @interest.prices.order('date desc').page(params[:page])
    @title = t('view.product_histories.index_title', product: @product.name, firm: @firm.nombre)
    if params[:firm].present?
      @product_histories = @product_histories.where(firm_id: params[:firm])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_histories }
    end
  end

  def new
    @price = @interest.prices.build
    @title = ( @interest.firm.present? ?
               t('view.purchase_interests.new_title_firm', product: @interest.product.name, firm: @interest.firm.nombre) :
               t('view.purchase_interests.new_title', product: @interest.product.name)
             )

    render partial: 'form', content_type: 'text/html'
  end

  def create
    @price = @interest.prices.build(params[:price])
    @price.user = @current_user
    @title = if @interest.firm.present?
               t('view.purchase_interests.new_title_firm', product: @interest.product.name, firm: @interest.firm.nombre)
             else
               t('view.purchase_interests.new_title', product: @interest.product.name)
             end


    if @price.save
      partial = case @interest
                  when PurchaseInterest
                    'purchase_interests/purchase_interest'
                  when SaleInterest
                    'sale_interests/sale_interest'
                end
      render partial: partial, locals: { interest: @interest }, content_type: 'text/html'
    else
      render partial: 'form', status: :unprocessable_entity
    end
  end

  private
    def get_interest
      @interest = Interest.find(params[:id])
    end

    def get_firm
      @firm = Firm.find(params[:firm]) if params[:firm]
    end
end
