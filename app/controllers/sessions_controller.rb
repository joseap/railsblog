class SessionsController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.find_by(email: params[:email])
		if @user && @user.password == params[:password]
			session[:user_id] = @user.id
			flash[:loggedin] = "You're now logged in"
			redirect_to @user
		else
			flash.now[:alert] = "Invalid email or password, please try again"
			render :new
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:loggedout] = "You've been logged out"
		redirect_to home_path
	end
end
