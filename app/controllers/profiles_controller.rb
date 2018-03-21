class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def send_photo
    @user = current_user
  end

  def save_photo
    @user = current_user
    #@user.image = params.require(:user).permit(:image)
    @user.image = params[:image]

    if @user.save
      redirect_to profile_path @user
    end
  end
end
