class PasswordsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user
      user.update(
        password_reset_token: SecureRandom.urlsafe_base64,
        password_reset_sent_at: Time.current
      )

      UserMailer.password_reset(user).deliver_now

      redirect_to login_path, notice: "Password reset instructions sent."
    else
      redirect_to "/password/reset", alert: "Email not found."
    end
  end

  def edit
    @user = User.find_by(password_reset_token: params[:token])
  end

  def update
    @user = User.find_by(password_reset_token: params[:token])

    if @user&.update(user_params)
      @user.update(
        password_reset_token: nil,
        password_reset_sent_at: nil
      )

      redirect_to login_path, notice: "Password updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
