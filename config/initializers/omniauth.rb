Rails.configuration.middleware.use OmniAuth::Builder do
  provider :twitter, AppConfig['twitter']['key'], AppConfig['twitter']['secret']
end
