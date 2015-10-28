class UsersController < ApplicationController
	def index
		@user = User.all
		if @user.present?
			flash[:notice] = "User List"
		else
			flash[:alert] = "No users where found"
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def new 
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.create(user_params)
			if @user.save
				session[:user_id] = @user.id
				flash[:created] = "New user created"
				redirect_to user_path(@user)
			else
				flash[:correct] = "Please fill out the form correctly"
				redirect_to new_user_path
			end
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		flash[:updated] = "User updated"
		redirect_to user_path	
	end

	def destroy 
		@user = User.find(params[:id])
		session[:user_id] = nil
		@user.destroy
		flash[:deleted] = "User deleted"
		redirect_to root_path
	end


	private
		def user_params
			params.require(:user).permit(:fname, :lname, :username, :email, :password, :country, :avatar)
		end

end
