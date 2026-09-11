class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  helper_method :current_user, :logged_in?, :language_path

  def set_locale
    locale = params[:locale].presence || session[:locale] || I18n.default_locale
    locale = I18n.default_locale unless I18n.available_locales.map(&:to_s).include?(locale.to_s)
    I18n.locale = locale.to_sym
    session[:locale] = I18n.locale.to_s
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def logged_in?
    current_user.present?
  end

  def authorize
    return if logged_in?

    respond_to do |format|
      format.html { redirect_to login_path(locale: I18n.locale), alert: t("mall_expert.auth.required") }
      format.json { render json: { error: t("mall_expert.auth.required") }, status: :unauthorized }
    end
  end

  def language_path(path = "")
    normalized_path = path.start_with?("/") ? path : "/#{path}"
    "/#{I18n.locale}#{normalized_path}"
  end

  def default_url_options
    { locale: I18n.locale }
  end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
