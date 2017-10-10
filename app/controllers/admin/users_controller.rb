class Admin::UsersController < AdminController

  def edit
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Password updated"
      bypass_sign_in(@user)
      redirect_to admin_index_path
    else
      render "edit"
    end
  end

private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
