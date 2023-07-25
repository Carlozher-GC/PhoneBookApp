require 'messages'

class ContactsController < ApplicationController
  before_action :set_contact, only: %i[edit update destroy]

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = CREATE_CONTACT_SUCCESS_MSG
      redirect_to(contacts_path)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @contact.update(contact_params)
      flash[:success] = UPDATE_CONTACT_SUCCESS_MSG
      redirect_to(contacts_path)
    else
      render 'edit'
    end
  end

  def destroy
    @contact.destroy
    flash[:success] = DELETE_CONTACT_SUCCESS_MSG
    redirect_to(contacts_path)
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:first_name,
                                    :last_name,
                                    :phone)
  end
end
