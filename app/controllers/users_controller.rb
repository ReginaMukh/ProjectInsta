class UsersController < ApplicationController
 

    def index
      @users = User.all
    end
  
    def new
      @user = User.new
    end
  
    def show
      @user = User.find(params[:id])
      @posts = @user.posts.paginate(page: params[:page])
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        flash.now[:alert] = "Error"
        render 'new'
      end
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      params = build_params(user_params)
      if @user.update(params)
        flash[:success] = "Profile updated"
        redirect_to user_url(@user)
      else
        render 'edit'
      end
    end

    
    def following
      @title = "Following"
      @user  = User.find(params[:id])
      @users = @user.following.paginate(page: params[:page])
      render 'show_follow'
    end
  
    def followers
      @title = "Followers"
      @user  = User.find(params[:id])
      @users = @user.followers.paginate(page: params[:page])
      render 'show_follow'
    end
  
    private
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
  
      def build_params(user_params)
        user_params[:password] = user_params[:password].presence
        user_params[:password_confirmation] = user_params[:password_confirmation].presence
        user_params.compact
      end

     

  
end
