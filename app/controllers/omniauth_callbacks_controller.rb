class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  require 'koala'
  

  def facebook
   
    auth = env["omniauth.auth"]
    @user =  User.where(provider: auth['provider'], uid: auth['uid']).first
    unless @user.present?
      @user = User.new
      @user.first_name = auth['info']['name']
      @user.email = auth['info']['email']
      @user.provider = auth['provider']
      @user.uid = auth['uid']
      @user.token = auth['credentials']['token']
      @user.skip_email_validations = true
      @user.save(validate: false)
    end
      if @user.present?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.facebook_uid"] = auth["uid"]
        redirect_to new_user_registration_url
      end
    end
  
  def google_oauth2
   auth = env["omniauth.auth"]
    @user =  User.where(provider: auth['provider'], uid: auth['uid']).first
    unless @user.present?
      @user = User.new
      @user.first_name = auth['info']['name']
      @user.provider = auth['provider']
      @user.uid = auth['uid']
      @user.skip_email_validations = true
      @user.save(validate: false)
    end
      if @user.present?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_uid"] = auth["uid"]
        redirect_to new_user_registration_url
      end
    end

  def twitter
    auth = env["omniauth.auth"]
    @user =  User.where(provider: auth['provider'], uid: auth['uid']).first
    unless @user.present?
      @user = User.new
      @user.first_name = auth['info']['name']
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