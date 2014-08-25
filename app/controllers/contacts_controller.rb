class ContactsController < ApplicationController
  expose(:contact, attributes: :contact_params)
  http_basic_authenticate_with name: ENV.fetch('ADMIN_NAME'),
    password: ENV.fetch('ADMIN_PASSWORD'), only: :index

  def index
    @contacts = Contact.all
  end

  def create
    if contact.save
      flash[:notice] = true
      session[:hide_training] = true
    else
      flash[:error] = true
    end
    redirect_to :back
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :location)
  end

end
