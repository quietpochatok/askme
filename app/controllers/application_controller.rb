class ApplicationController < ActionController::Base
    helper_method :current_user

    private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def reject_user
      redirect_to root_path, alert: 'Вам сюда низя! Ухадите!'
    end
end
    #   helper_method :current_user, :logged_in?

    # def current_user
    #   @current_user ||= User.find_by_id(session[:user])
    # end

    #  def logged_in?
    #    current_user != nil
    #  end


    # def current_user
    #   # @current_user ||= User.find_by_id(@user)
    #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    # end

    # helper_method :current_user

