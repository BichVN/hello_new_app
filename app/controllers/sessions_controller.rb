class SessionsController < ApplicationController
  def new
  end

  def create
   	user = User.find_by(email: params[:session][:email].downcase )
   	if user && user.authenticate(params[:session][:password])
   		log_in user
   		params[:session][:remember_me] == '1' ? remember(user) : forget(user)
   		redirect_back_or user
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

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
end
