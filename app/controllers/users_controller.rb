class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params_user)

  	if @user.save
  		redirect_to root_path
  	else
  		render "new"
  	end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  	def params_user
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

end
