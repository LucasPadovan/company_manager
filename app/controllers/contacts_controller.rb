class ContactsController < ApplicationController
  before_filter :get_firm

  def edit
    @contact = Contact.includes(:firm).find(params[:id])
    @title = t('view.contacts.edit_title', contact: @contact.name, firm: @contact.firm.nombre)
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @title = t('view.contacts.new_title')
    @contact = @firm.contacts.build(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @firm, notice: t('view.contacts.correctly_created') }
        format.json { render json: @firm, status: :created, location: @contact }
      else
        format.html { render nothing: true }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.includes(:firm).find(params[:id])
    @title = t('view.contacts.edit_title', contact: @contact.name, firm: @contact.firm.nombre)

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @firm, notice: t('view.contacts.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_firm_contact_path(@firm, @contact), alert: t('view.contacts.stale_object_error')
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to @firm }
      format.json { head :ok }
    end
  end

  private
    def get_firm
      @firm = Firm.find(params[:firm_id])
    end
end
