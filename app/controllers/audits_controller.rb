class AuditsController < ActionController::Base
  
  before_filter :authorized?
  
  def authorized?
    current_flyer && BeadsKoolbzComAu::Application.config.security[:authorized].include?(current_flyer.email) 
    true
  end

end
