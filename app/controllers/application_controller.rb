# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_locale
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  
  protected
  
  def set_locale
    locale = extract_locale_from_subdomain || extract_locale_from_url || extract_locale_from_cookie || extract_from_default
    if locale
      cookies[:locale] = locale
      I18n.locale = locale
    end
  end
  
  protected
  
  # Get locale code from request subdomain (like http://it.application.local:3000)
  # You have to put something like:
  #   127.0.0.1 gr.application.local
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    logger.warn "Subdomain: #{parsed_locale}"
    (parsed_locale and I18n.available_locales.include? parsed_locale.to_sym) ? parsed_locale.to_sym  : nil
  end
  
  def extract_locale_from_url
    parsed_locale = params[:locale]
    logger.warn "Parameter: #{parsed_locale}"
    (parsed_locale and I18n.available_locales.include? parsed_locale.to_sym) ? parsed_locale.to_sym  : nil
  end
  
  def extract_locale_from_cookie
    cookies[:locale]
  end
  
  def extract_from_default
    I18n.default_locale
  end
end
