class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user
    helper_method :current_cocktail
    
    def index
    end 

    def current_user
        @user = User.find_by(id: session[:user_id])
    end 

    def logged_in?
        !!session[:user_id]
    end 

    def current_cocktail
        @cocktail = Cocktail.find_by(id: params[:id])
    end 

    def destroy_favorites(cocktail_id)
        #favorites = []
        @cf = Favorite.all.where(cocktail_id: cocktail_id)
            @cf.each do |f|
                f.destroy
            end 

            #favorites.all.destroy
    end
    
end
