class MicropostsController < ApplicationController
	before_action :must_be_logged_in

	def create
		@micropost = Micropost.new(params_micropost)

		if @micropost.save
			current_user.microposts << @micropost
			flash[:success] = "Posted!"
			redirect_to user_path(current_user.id)
		else
			flash[:danger] = "Wrong message length!"
			redirect_to user_path(current_user.id)
		end
	end

	def destroy
		@micropost = current_user.microposts.find(params[:id])
		@micropost.destroy if @micropost
		flash[:success] = 'Message deleted!'
		redirect_to root_path
	end

	private

		def params_micropost
			params.require(:micropost).permit(:post)
		end

		def must_be_logged_in
			unless current_user
				flash[:warning] = "Please, log in."
				redirect_to login_path
			end
		end
end
