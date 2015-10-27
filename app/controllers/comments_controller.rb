class CommentsController < ApplicationController

	def new
		@comment = Comment.new
	end

	def create
		Comment.create(body: params[:comment][:body], 
			post_id: params[:post_id], 
			user_id: session[:user_id])

		redirect_to	post_path(params[:post_id])
	end

	def edit 
		@comment = Comment.find(params[:id])
	end

	def update 
		@comment = Comment.find(params[:id])
		@comment.update(comment_params)
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
		flash[:destroyed] = "Comment deleted"
	end

	private 
		def comment_params
			params.require(:comment).permit(:body)
		end
end
