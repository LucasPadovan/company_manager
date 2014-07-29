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
    @firm = Firm.includes(:purchase_interests).find(params[:id])
    @title = t('view.firms.show_title', firm: @firm.nombre)
    @purchase_interests = @firm.purchase_interests
    @sale_interests = @firm.sale_interests

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
    @firm = Firm.find(params[:id])
    @title = t('view.firms.edit_title', firm: @firm.nombre)
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

  def add_product
    @firm = Firm.find(params[:id])

    render partial: 'add_product', content_type: 'text/html'
  end
end
