class CommentsController < ApplicationController

	def new
		@post = Post.find(params[:post_id])
		@comment = Comment.new
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		redirect_to	post_path(@post)
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
