class PostsController < ApplicationController
    before_action :authenticate_user!,  except:[:index, :show]
    before_action :find_post, only:[:show, :edit, :update, :destroy]
    before_action :authorize_user!, only:[:edit, :update, :destroy]
    def index
        @posts=Post.all.order(created_at: :desc)
    end
    def create
        @posts=Post.new post_params
        @posts.user = current_user
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
        if can?(:edit, @posts)
            render :edit
        else
            redirect_to post_path(@posts)
        end
    end
    def show
        @comment=Comment.new
        @comments= @posts.comments.order(created_at: :desc)
    end
    def destroy
        @posts.destroy
        flash[:danger]= 'deleted job post'
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
    def authorize_user!
        redirect_to post_path(@posts), alert: "Not Authorized" unless can?(:crud, @posts)
    end
end

