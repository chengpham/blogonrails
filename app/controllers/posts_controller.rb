class PostsController < ApplicationController
    before_action :find_post, only:[:show, :edit, :update, :destroy]
    def index
        @posts=Post.all.order(created_at: :desc)
    end
    def create
        @posts=Post.new post_params
        # @post.user = current_user
        if @posts.save
            redirect_to post_path(@posts.id)
        else
            render :new
        end
    end
    def new
        @posts=Post.new
    end
    def edit 
    end
    def show
        @comment=Comment.new
    end
    def destroy
        @posts.destroy
        redirect_to posts_path
    end
    def update
        if @posts.update post_params
            redirect_to post_path(@posts.id)
        else
            render :edit
        end
    end
    private
    def find_post
        @posts=Post.find params[:id] 
    end
    def post_params
        params.require(:post).permit(:title, :body)
    end
end

