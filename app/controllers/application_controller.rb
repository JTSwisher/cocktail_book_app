class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user
    helper_method :current_cocktail
    
    def hello
    end 

    def current_user
        @user = User.find_by(id: session[:user_id])
    end 

    def current_cocktail
        @cocktail = Cocktail.find_by(id: params[:id])
    end 
    
end
