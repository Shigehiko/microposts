class UsersController < ApplicationController
  before_action :show, only: [:edit, :update]
  
  def show 
  @user = User.find(params[:id])
  @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def settings
    @user = User.find(params[:id])
  end
  
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:info] = I18n.t("controllers.common.Updated profile")
      redirect_to settings_user_path(current_user)
    else
      render 'edit'
    end
  end
  
  
 
  def new
    @user = User.new
  end

  
  def create
    @user = User.new(user_params)
    if @user.save
       flash[:success] = I18n.t("controllers.common.Welcome to the Microposts")
       redirect_to @user
    else
      render 'new'
    end
  end
  
 
  def followings
    @title = "Followings"
    @user = User.find(params[:id])
    @microposts = @user.microposts
    @users = @user.following_users
    render :file => "users/show_follow"
    
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.follower_users
    @microposts = @user.microposts
    render :file => "users/show_follow"
  end
  


  private
  def user_params
    params.require(:user).permit(:name, :email, :area, :password,
                                 :password_confirmation)
  end
end
