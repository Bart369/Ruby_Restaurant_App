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
    
    

    def current_user
      #if @current_user is nil /false, run find_current_user
      @current_user ||= find_current_user
    end

    def find_current_user
      token = session[:session_token]
      token && User.find_by(session_token: token)
    end

    #the first time the app searches for current user it will run the methods 
    # in find_current_user, but every other time the info will be cached (stored)
    # so it wont have to run the methods again making finding current much cheaper 

    def sign_out
      session.delete(:session_token)
      current_user.update_attribute(:session_token, nil)
    end
  

end
