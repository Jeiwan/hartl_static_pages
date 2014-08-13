class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by_email(params[:email])

  	if @user && @user.authenticate(params[:password])
      sign_in @user
      flash[:success] = 'Logged in!'
  		redirect_to(session[:dead_end] || @user)
      session[:dead_end] = nil
  	else
  		flash.now[:danger] = "Invalid email or password!"
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end
end
