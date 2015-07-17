class SessionsController < ApplicationController
  def new
  end

  def create
   	user = User.find_by(email: params[:session][:email].downcase )
   	if user && user.authenticate(params[:session][:password])
   		log_in user
   		redirect_to user
   	else
   		flash[:danger] = 'Invalid email/password combination' # Not quite right!	
			render 'new'  
	end	
  end

 # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def detroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
