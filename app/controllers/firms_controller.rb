class FirmsController < ApplicationController
  
  # GET /firms
  # GET /firms.json
  def index
    @title = t('view.firms.index_title')
    @firms = Firm.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @firms }
    end
  end

  # GET /firms/1
  # GET /firms/1.json
  def show
    @title = t('view.firms.show_title')
    @firm = Firm.find(params[:id])
    @sale_histories = []
    @product_histories = []
    Product.joins(:sale_histories).where("sale_histories.firm_id = #{@firm.id}").select('DISTINCT products.*').each do |product|
      @sale_histories << product.sale_histories.order(:date).last
    end
    Product.joins(:product_histories).where("product_histories.firm_id = #{@firm.id}").select('DISTINCT products.*').each do |product|
      @product_histories << product.product_histories.order(:date).last
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @firm }
    end
  end

  # GET /firms/new
  # GET /firms/new.json
  def new
    @title = t('view.firms.new_title')
    @firm = Firm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @firm }
    end
  end

  # GET /firms/1/edit
  def edit
    @title = t('view.firms.edit_title')
    @firm = Firm.find(params[:id])
  end

  # POST /firms
  # POST /firms.json
  def create
    @title = t('view.firms.new_title')
    @firm = Firm.new(params[:firm])

    respond_to do |format|
      if @firm.save
        format.html { redirect_to @firm, notice: t('view.firms.correctly_created') }
        format.json { render json: @firm, status: :created, location: @firm }
      else
        format.html { render action: 'new' }
        format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /firms/1
  # PUT /firms/1.json
  def update
    @title = t('view.firms.edit_title')
    @firm = Firm.find(params[:id])

    respond_to do |format|
      if @firm.update_attributes(params[:firm])
        format.html { redirect_to @firm, notice: t('view.firms.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_firm_url(@firm), alert: t('view.firms.stale_object_error')
  end

  # DELETE /firms/1
  # DELETE /firms/1.json
  def destroy
    @firm = Firm.find(params[:id])
    @firm.destroy

    respond_to do |format|
      format.html { redirect_to firms_url }
      format.json { head :ok }
    end
  end
end
