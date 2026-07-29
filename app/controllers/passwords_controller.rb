class PasswordsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user
      user.update(
        password_reset_token: user.generate_token_for(:password_reset),
        password_reset_sent_at: Time.current
      )

      UserMailer.password_reset(user).deliver_now

      redirect_to login_path, notice: "Password reset instructions sent."
    else
      redirect_to "/password/reset", alert: "Email not found."
    end
  end

  def edit
    @user = User.find_by_token_for(:password_reset, params[:token])

    redirect_to login_path, alert: "Invalid or expired password reset link." unless @user
  end

  def update
    @user = User.find_by_token_for(:password_reset, params[:token])

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
