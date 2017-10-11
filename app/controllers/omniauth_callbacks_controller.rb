class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
# You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  # def from_omniauth_twitter(auth)

  #   user = where(provider: auth['provider'], uid: auth['uid']).first
  #    if user.present?
  #      user
  #    else
  #     user = User.new
  #      user.name = auth['name']
  #      user.email = auth['email']
  #      user.save

  #    end
    
  #    user
  #  end

  def twitter
  # You need to implement the method below in your model
    auth = env["omniauth.auth"]
    @user =  User.where(provider: auth['provider'], uid: auth['uid']).first
    unless @user.present?
      @user = User.new
      @user.email = auth['info']['name']
      @user.provider = auth['provider']
      @user.uid = auth['uid']
      @user.save(validate: false)
    end
      if @user.present?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.twitter_uid"] = auth["uid"]
        redirect_to new_user_registration_url
      end
    end
  end
# def twitter
#   # You need to implement the method below in your model
#   auth = env["omniauth.auth"]
#   @user = user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.new
#   if @user.persisted?
#     flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
#     sign_in_and_redirect @user, :event => :authentication
#   else
#     session["devise.twitter_uid"] = auth["uid"]
#     redirect_to new_user_registration_url
#   end
# end

