class CommentsController < ApplicationController
    before_action :find_post, only:[:create, :destroy]
    def create
        @comment = Comment.new comment_params
        @comment.post = @posts
        @comment.save
        redirect_to post_path(@posts)
    end
    def destroy
        @comment = Comment.find params[:id]
        @comment.destroy
        redirect_to post_path(@posts), alert: "Comment deleted"
    end
    private
    def comment_params
        params.require(:comment).permit(:body)
    end
    def find_post
        @posts=Post.find params[:post_id] 
    end
end
