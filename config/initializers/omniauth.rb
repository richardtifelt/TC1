Rails.configuration.middleware.use OmniAuth::Builder do
  provider :twitter, "1V9lty4RBVlA0E5TObJFw", "IBZgFxmzVQltxhg4wIYhv4F4IHrdvMhLdBplSvuj5lc", {:callback_path => "/auth_twitter"}
end
