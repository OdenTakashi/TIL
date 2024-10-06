class ProfilesController < ApplicationController
  def show
  end

  def edit
  end

  def update
    user = current_user
    user.update(update_params)
  end

  private

  def update_params
    if current_user.admin?
      params.requre(:user).permit(:name, :email, :admin)
    else
      params.require(:user).permit(:name, :email)
    end
  end
end
