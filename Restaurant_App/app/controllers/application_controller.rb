class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

    def sign_in(user)
      #SecureRandom is a built-in ruby method
      token = SecureRandom.urlsafe_base64 # random 22-char string
      session[:session_token] = token
      user.update_attribute(:session_token, token)
    end

    
    # def current_user
    #   token = session[:session_token]
    #   token && User.find_by(session_token: token)
    # end

    # we could do the above but this would require running User.find_by everytime which is a very
    # expensive method. Instead we can cache the info after running once so that we only need to 
    # run it once and just check the cache

    #the first time the app searches for current user it will run the methods 
    # in find_current_user, but every other time the info will be cached (stored)
    # so it wont have to run the methods again making finding current much cheaper 
    def current_user
      #if @current_user is nil /false, run find_current_user
      @current_user ||= find_current_user
    end

    def find_current_user
      token = session[:session_token]
      token && User.find_by(session_token: token)
    end

    # to ensure a user is signed in before visiting a page
    def ensure_signed_in
      return if current_user
      flash[:error] = 'you must be signed in to be here'
      redirect_to root_path
    end

    # to ensure a user is signed out before they can a see a page
    # such as creating a new user
    def ensure_signed_out
      return unless current_user
      flash[:error] = 'you are signed in so you cant see that'
      redirect_to restaurants_path
    end

    def sign_out
      return unless current_user
      current_user.update!(session_token: nil)
      session.delete(:session_token)
    end
  

end
