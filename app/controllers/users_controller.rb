class UsersController < ApplicationController

  before_action :must_be_logged_in, only: [:edit, :update]
  before_action :must_be_an_admin, only: [:destroy]

  def index
    @users = User.order(:id).paginate(page: (params[:page] || 1), per_page: 10)
  end

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
    @micropost = Micropost.new
    @microposts = @user.feed.paginate(page: (params[:page] || 1), per_page: 20)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    if @user.update(params_user)
      flash[:success] = 'Updated!'
      redirect_to @user
    else
      flash.now[:danger] = 'Error!'
      render "edit" 
    end
  end

  def destroy
    if current_user.id.to_s != params[:id]
      @user = User.find(params[:id])
      @user.destroy
      flash[:success] = "User is deleted!"
    end
    redirect_to users_path
  end

	def follow
		@user_to_follow = User.find(params[:id])
		if @user_to_follow
			current_user.follow!(@user_to_follow)
			flash[:success] = "Now following #{@user_to_follow.name}"
			redirect_to user_path(@user_to_follow.id)
		else
			redirect_to root_path
		end
	end

	def unfollow
		@user_to_unfollow = User.find(params[:id])
		if @user_to_unfollow
			current_user.unfollow!(@user_to_unfollow)
			flash[:success] = "No more following #{@user_to_unfollow.name}"
			redirect_to user_path(@user_to_unfollow.id)
		else
			redirect_to root_path
		end
	end

  private
  	def params_user
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def must_be_logged_in
      unless signed_in?
        session[:dead_end] = request.url if request.get?
        flash[:warning] = "Please, sign in."
        redirect_to login_path
      end
    end

    def must_be_an_admin
      unless signed_in? && current_user.admin?
        redirect_to root_path
      end
    end
end
