class PurchaseInterestsController < ApplicationController
  def new
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      @title = t('view.interests.new.purchase_product_title', product: @product)
    else
      @firm = Firm.find(params[:firm_id])
      @title = t('view.interests.new.purchase_firm_title')
    end

    @firm_or_product = @firm || @product
    @purchase_interest = @firm_or_product.purchase_interests.build
    @purchase_interest.prices.build

    render partial: 'new', content_type: 'text/html'
  end

  def create
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      @title = t('view.interests.new.purchase_product_title', product: @product)
    else
      @firm = Firm.find(params[:firm_id])
      @title = t('view.interests.new.purchase_firm_title')
    end

    @firm_or_product = @firm || @product
    @purchase_interest = @firm_or_product.purchase_interests.build(params[:purchase_interest])

    if @purchase_interest.save
      render partial: 'purchase_interests/purchase_interest', locals: { interest: @purchase_interest }, content_type: 'text/html'
    else
      render partial: 'new', locals: { type: params[:type] }, status: :unprocessable_entity
    end
  end

  def destroy
    @interest = Interest.find(params[:id])
    if @interest.destroy
      render nothing: true, content_type: 'text/html'
    else
      render nothing: true
    end
  end
end