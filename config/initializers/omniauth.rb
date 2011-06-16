Rails.configuration.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider :twitter, "1V9lty4RBVlA0E5TObJFw", "IBZgFxmzVQltxhg4wIYhv4F4IHrdvMhLdBplSvuj5lc"
  else
    provider :twitter, "RW4KqKih7fkw9N59GpffLg", "KbEsl5rBJSFbIgMDgM0zXuvnN7qoJDPENe9DK2pZhAY"
  end
end
