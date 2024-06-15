class HomeController < ApplicationController

  def index 
  end

  def about
  end

  def contact_form
    contact_params = params.permit(:full_name, :email, :message)
    if ContactMailer.contact_email(contact_params[:full_name], contact_params[:email], contact_params[:message]).deliver_now
      flash[:notice] = "Thank you for your message. We'll get back to you soon."
      redirect_to root_path
    else
      flash[:alert] = "There was an error sending your message. Please try again."
      render :new
    end
  end
end
