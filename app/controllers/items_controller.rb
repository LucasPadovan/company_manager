class ItemsController < ApplicationController
  before_filter :get_order

  def new
    @item = @order.items.build
    @title = t('view.items.new_title')

    render partial: 'new', content_type: 'text/html'
  end

  def create
    @item = @order.items.new(params[:item])
    @title = t('view.items.new_title')

    if @item.save
      render partial: 'items/item', locals: { item: @item }, content_type: 'text/html'
    else
      render partial: 'items/new', status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      render nothing: true, content_type: 'text/html'
    end

  end

  private
    def get_order
      @order = Order.find(params[:order_id])
    end
end