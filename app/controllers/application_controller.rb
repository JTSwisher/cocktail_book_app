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

    def require_login
        if !logged_in?  
          flash[:alert] = "Please login to continue" 
          redirect_to root_path
        end
    end

    def current_cocktail
        @cocktail = Cocktail.find_by(id: params[:id])
    end

    def current_favorite_object
        @favorite = Favorite.find_by(id: params[:id])
    end 
    
    def current_favorite_cocktail
        favorite = current_favorite_object
        @cocktail = Cocktail.find(favorite.cocktail_id)
    end

    def destroy_favorites(cocktail_id)
        @cf = Favorite.all.where(cocktail_id: cocktail_id)
        
        @cf.each do |f|
            f.destroy
        end 
    end
    
    def cocktail_ownership
        if !current_user.cocktails.include?(current_cocktail)
            flash[:alert] = "You do not have edit permissions"
            redirect_to user_path(current_user)
        end 
    end

    def favorite_ownership
        if !current_user.favorites.include?(current_favorite_object)
            flash[:alert] = "You do not have edit permissions"
            redirect_to user_path(current_user)
        end 
    end 
        
end
