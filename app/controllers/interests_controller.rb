class InterestsController < ApplicationController
  def new
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      @title = t("view.interests.new.#{params[:type]}_product_title", product: @product)
      @interest = @product.interests.build
    else
      @firm = Firm.find(params[:firm_id])
      @title = t("view.interests.new.#{params[:type]}_firm_title")
      @interest = @firm.interests.build
    end

    render partial: 'new', content_type: 'text/html'
  end

  def create

  end

  def destroy

  end
end