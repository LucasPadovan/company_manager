class PurchaseInvoicesController < ApplicationController
  
  # GET /purchase_invoices
  # GET /purchase_invoices.json
  def index
    @title = t('view.purchase_invoices.index_title')
    @purchase_invoices = PurchaseInvoice.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchase_invoices }
    end
  end

  # GET /purchase_invoices/1
  # GET /purchase_invoices/1.json
  def show
    @title = t('view.purchase_invoices.show_title')
    @purchase_invoice = PurchaseInvoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase_invoice }
    end
  end

  # GET /purchase_invoices/new
  # GET /purchase_invoices/new.json
  def new
    @title = t('view.purchase_invoices.new_title')
    @purchase_invoice = PurchaseInvoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase_invoice }
    end
  end

  # GET /purchase_invoices/1/edit
  def edit
    @title = t('view.purchase_invoices.edit_title')
    @purchase_invoice = PurchaseInvoice.find(params[:id])
  end

  # POST /purchase_invoices
  # POST /purchase_invoices.json
  def create
    @title = t('view.purchase_invoices.new_title')
    @purchase_invoice = PurchaseInvoice.new(params[:purchase_invoice])

    respond_to do |format|
      if @purchase_invoice.save
        format.html { redirect_to @purchase_invoice, notice: t('view.purchase_invoices.correctly_created') }
        format.json { render json: @purchase_invoice, status: :created, location: @purchase_invoice }
      else
        format.html { render action: 'new' }
        format.json { render json: @purchase_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /purchase_invoices/1
  # PUT /purchase_invoices/1.json
  def update
    @title = t('view.purchase_invoices.edit_title')
    @purchase_invoice = PurchaseInvoice.find(params[:id])

    respond_to do |format|
      if @purchase_invoice.update_attributes(params[:purchase_invoice])
        format.html { redirect_to @purchase_invoice, notice: t('view.purchase_invoices.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @purchase_invoice.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_purchase_invoice_url(@purchase_invoice), alert: t('view.purchase_invoices.stale_object_error')
  end

  # DELETE /purchase_invoices/1
  # DELETE /purchase_invoices/1.json
  def destroy
    @purchase_invoice = PurchaseInvoice.find(params[:id])
    @purchase_invoice.destroy

    respond_to do |format|
      format.html { redirect_to purchase_invoices_url }
      format.json { head :ok }
    end
  end
end
