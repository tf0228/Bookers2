class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user), flash: {notice: "You have updated user successfully." }
  end

  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
end