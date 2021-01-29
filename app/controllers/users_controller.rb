class UsersController < ApplicationController
    before_action :authenticate_user!,  except:[:create, :new]
    def new
        @user=User.new
    end
    def create
        @user=User.new user_params
        if @user.save
            session[:user_id]=@user.id
            redirect_to root_path, notice: "Logged in!"
        else
            render :new
        end
    end
    def update
        if current_user.update user_params
            redirect_to edit_user_path, notice: "Profile successfully changed"
        else
            render :edit
        end
    end
    def edit
        @user = User.find current_user.id
    end
    def edit_password
        @user = current_user
    end
    def update_password
        @user=current_user
        if params[:user][:password] == params[:user][:current_password]
            flash[:alert] = "Can not use current password"
            render :edit
        elsif @user&.authenticate(params[:user][:current_password])
            if @user.update user_params
                redirect_to edit_user_path, notice: "Profile successfully changed"
            else
                flash[:alert] = "Passwords did not match"
                render :edit
            end
        else
            flash[:alert] = "Current password incorrect"
            render :edit
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
