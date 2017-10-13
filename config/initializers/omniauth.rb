# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :facebook, "1815767572034819", "b2b271db6861f8c7271a8ba5bbde9a13"
# end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "YRBuBRVn3j5XWvd0eP2U5YOmt", "REtlHbNKEwLg20RmfZXLUnWOVCmzJIVm6CV0kMxp5tHvZobIPC"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "25258943244-sr6avm8a78st0bfv3r6tr6kf0f2ojtl1.apps.googleusercontent.com", "vpYUUtcOM6jUFOKXG6bW0EAU"
end
# use OmniAuth::Builder do
#   provider :facebook, ENV['1815767572034819'], ENV['b2b271db6861f8c7271a8ba5bbde9a13'],
#     client_options: {
#       site: 'https://graph.facebook.com/v3.0',
#       authorize_url: "https://www.facebook.com/v3.0/dialog/oauth"
#     }
# end

