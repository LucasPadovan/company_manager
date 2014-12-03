class OrdersController < ApplicationController

  def index
    @title = t('view.orders.index_title')
    @orders = Order.open

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  def show
    @order = Order.find(params[:id])
    @title = t('view.orders.show_title', order_number: @order.number)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def new
    @order = Order.new
    @title = t('view.orders.new_title')
    @order.generate_number

    render partial: 'new', content_type: 'text/html'
  end

  def edit
    @order = Order.find(params[:id])
    @title = t('view.orders.edit_title', order_number: @order.number)

    render partial: 'edit', content_type: 'text/html'
  end

  def create
    @order = Order.new(params[:order])
    @title = t('view.orders.new_title')
    @order.generate_number
    @order.user = @current_user

    if @order.save
      js_redirect to: :show
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  def update
    @order = Order.find(params[:id])
    @title = t('view.orders.edit_title', order_number: @order.number)

    if @order.update_attributes(params[:order])
      js_redirect to: :show
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.cancell!
      redirect_to :index
    end
  end
end
