class Flyers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = Flyer.find_for_facebook_oauth(request.env["omniauth.auth"], current_flyer)

    if @user.present? && @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      #redirect_to new_flyer_registration_url
      redirect_to root_path
    end
  end
  
  # Override
  def failure
    logger.error("OmniauthCallbacksController failure_message: #{failure_message}")
    set_flash_message :alert, :failure, :kind => failed_strategy.name.to_s.humanize, :reason => failure_message
    #flash[:alert] = I18n.t "devise.omniauth_callbacks.flyer.failure", :kind => failed_strategy.name.to_s.humanize, :reason => failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end
  
  def after_omniauth_failure_path_for(scope)
    logger.warn("after_omniauth_failure_path_for #{scope}")
    root_path
  end
end