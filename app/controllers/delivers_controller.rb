class DeliversController < ApplicationController
  before_filter :get_item

  def index
    @delivers = @item.delivers
    @title = t('view.delivers.index_title', product: @item.product.name)

    render partial: 'delivers/index', content_type: 'text/html'
  end

  def new
    @deliver = @item.delivers.build
    @title = t('view.delivers.new_title')

    render partial: 'delivers/new', content_type: 'text/html'
  end

  def create
    @deliver = @item.delivers.new(params[:deliver])
    @title = t('view.delivers.new_title')

    if @deliver.save
      render partial: 'items/item', locals: { item: @item.reload }, content_type: 'text/html'
    else
      render partial: 'delivers/new', status: :unprocessable_entity
    end

  end

  def destroy
    @deliver = Deliver.find(params[:id])

    if @deliver.destroy
      redirect_to order_path(@order)
    end
  end

  private
    def get_item
      @item  = Item.includes(:order).find(params[:item_id])
      @order = @item.order
    end
end