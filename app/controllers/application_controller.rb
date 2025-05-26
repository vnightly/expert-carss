include SessionsHelper

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :redirect_to_login_unless_authenticated

  def extr_locale_in_accept_lang
    locale = params[:locale]
    logger.info "In extr_locale_in_accept_lang: locale =
 #{locale}"
  end

  private

  def set_locale_from_params
    if params[:locale]
      extr_locale_in_accept_lang
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
        logger.info flash.now[:notice]
      else
        flash.now[:alarm] = " #{params[:locale]} Перевод
 страницы отсутствует"
        logger.error flash.now[:alarm]
      end
      params[:locale]
    end
  end

  def set_locale
    I18n.locale = set_locale_from_params || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end


  private

  def redirect_to_login_unless_authenticated
    return if controller_name == 'sessions' || controller_name == 'users'

    unless signed_in?
      redirect_to signin_path
    end
  end
end
