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

    if params[:type] == 'purchase'
      @product_history = @interest.product_histories.build
    else
      @sale_history = @interest.sale_histories.build
    end

    render partial: 'new', content_type: 'text/html'
  end

  def create
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      @title = t("view.interests.new.#{params[:type]}_product_title", product: @product)
      @interest = @product.interests.build(params[:interest])
    else
      @firm = Firm.find(params[:firm_id])
      @title = t("view.interests.new.#{params[:type]}_firm_title")
      @interest = @firm.interests.build(params[:interest])
    end
    if @interest.save
      render partial: 'interests/interest', locals: { interest: @interest }, content_type: 'text/html'
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