Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "399702043433879", "a885e3a8c56122598052ea414044ce4d", :strategy_class => OmniAuth::Strategies::Facebook, :display => 'popup', :scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access, publish_stream'
end