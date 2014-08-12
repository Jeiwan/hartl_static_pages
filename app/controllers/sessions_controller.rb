class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by_email(params[:email])

  	if @user && params[:password] == params[:password_confirmation] && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
      flash[:success] = 'Logged in!'
  		redirect_to @user
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
