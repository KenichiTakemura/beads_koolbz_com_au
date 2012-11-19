class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  def set_locale
    I18n.locale = params[:locale].presence || BeadsKoolbzComAu::Application.config.i18n.default_locale
    Rails.logger.debug("locale: #{I18n.locale}")
  end

  def after_sign_in_path_for(resource)
    logger.info("after_sign_in_path_for request.referer: #{request.referer}")
    request.env['omniauth.origin'] || request.referer || stored_location_for(resource) || root_path
  end
end
