class SessionsController < ApplicationController
  def new
    redirect_to malls_path(locale: I18n.locale) if logged_in?
  end

  def create
    user = User.find_by(email: params[:email].to_s.downcase.strip)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to malls_path(locale: I18n.locale), notice: t("mall_expert.auth.login_success")
    else
      flash.now[:alert] = t("mall_expert.auth.invalid_credentials")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path(locale: I18n.locale), notice: t("mall_expert.auth.logout_success")
  end
end
