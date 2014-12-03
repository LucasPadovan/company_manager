class ClientOrdersController < ApplicationController

  def index
    @title = t('view.client_orders.index_title')
    @client_orders = ClientOrder.open

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @client_orders }
    end
  end

  def show
    @client_order = ClientOrder.find(params[:id])
    @title = t('view.client_orders.show_title', order_number: @client_order.number)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def new
    @client_order = ClientOrder.new
    @title = t('view.client_orders.new_title')

    render partial: 'new', content_type: 'text/html'
  end

  def edit
    @client_order = ClientOrder.find(params[:id])
    @title = t('view.client_orders.edit_title', order_number: @client_order.number)

    render partial: 'edit', content_type: 'text/html'
  end

  def create
    @client_order = ClientOrder.new(params[:order])
    @title = t('view.client_orders.new_title')
    @client_order.user = @current_user

    if @client_order.save
      js_redirect to: :show
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  def update
    @client_order = ClientOrder.find(params[:id])
    @title = t('view.client_orders.edit_title', order_number: @client_order.number)

    if @client_order.update_attributes(params[:order])
      js_redirect to: :show
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @client_order = ClientOrder.find(params[:id])
    if @client_order.cancell!
      redirect_to :index
    end
  end
end
