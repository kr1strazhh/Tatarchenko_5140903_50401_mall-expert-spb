class UsersController < ApplicationController
  def new
    redirect_to malls_path(locale: I18n.locale) if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to malls_path(locale: I18n.locale), notice: t("mall_expert.auth.signup_success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
