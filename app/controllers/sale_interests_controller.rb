class SaleInterestsController < ApplicationController
  def new
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      @title = t('view.interests.new.sale_product_title', product: @product)
    else
      @firm = Firm.find(params[:firm_id])
      @title = t('view.interests.new.sale_firm_title')
    end

    @firm_or_product = @firm || @product
    @sale_interest = @firm_or_product.sale_interests.build
    @sale_interest.prices.build

    render partial: 'new', content_type: 'text/html'
  end

  def create
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      @title = t('view.interests.new.sale_product_title', product: @product)
    else
      @firm = Firm.find(params[:firm_id])
      @title = t('view.interests.new.sale_firm_title')
    end

    @firm_or_product = @firm || @product
    @sale_interest = @firm_or_product.sale_interests.build(params[:sale_interest])

    if @sale_interest.save
      render partial: 'sale_interests/sale_interest', locals: { interest: @sale_interest }, content_type: 'text/html'
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