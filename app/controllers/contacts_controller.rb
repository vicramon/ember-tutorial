class ContactsController < ApplicationController
  expose(:contact, attributes: :contact_params)

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
