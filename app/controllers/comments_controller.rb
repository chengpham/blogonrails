class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_post, only:[:create, :destroy]
    before_action :find_comment, only:[:destroy]

    before_action :authorize_user!, only:[:destroy]
    def create
        @comment = Comment.new comment_params
        @comment.post = @posts
        @comment.user = current_user
        @comment.save
        redirect_to post_path(@posts)
    end
    def destroy
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
    def find_comment
        @comment = Comment.find params[:id]
    end
    def authorize_user!
        redirect_to root_path, alert: "Not Authorized" unless can?(:crud, @comment)
    end
end
