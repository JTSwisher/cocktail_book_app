class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user
    helper_method :current_cocktail
    
    def index
        #root
    end 

    def current_user
        #find current user.
        @user = User.find_by(id: session[:user_id])
    end 

    def logged_in?
        #verify login making sure session user_id evaluates to true 
        !!session[:user_id]
    end 

    def require_login
        # verify that user is logged in before accessing resources
        if !logged_in?  
          flash[:alert] = "Please login to continue" 
          redirect_to root_path
        end
    end

    def current_cocktail
        #find current cocktail
        @cocktail = Cocktail.find_by(id: params[:id])
    end

    def current_favorite_object
        #finds associated favorite object for show, edit, update, destroy actions
        @favorite = Favorite.find_by(id: params[:id])
    end 
    
    def current_favorite_cocktail
        #user current_favorite_object method to find associated cocktail of favorite object for show, edit, update, destropy actions
        favorite = current_favorite_object
        @cocktail = Cocktail.find(favorite.cocktail_id)
    end

    def destroy_favorites(cocktail_id)
        # Find all favorites with cocktail_id of associated coktail that was deleted and delete those favorite objects upon
        #cocktail deletion
        @cf = Favorite.all.where(cocktail_id: cocktail_id)
        
        @cf.each do |f|
            f.destroy
        end 
    end

    def destroy_top_cocktail(cocktail_id)
        @top_cocktail = TopCocktail.find(cocktail_id: cocktail_id)
        @cocktail.destroy
    end 

    
    def cocktail_ownership
        #check cocktail object ownership before allowing edit, update, desstroy actions on object by user
        if !current_user.cocktails.include?(current_cocktail)
            flash[:alert] = "You do not have edit permissions"
            redirect_to user_path(current_user)
        end 
    end

    def favorite_ownership
        #check favorite object ownership before allowing edit,update,destroy actions on object by user
        if !current_user.favorites.include?(current_favorite_object)
            flash[:alert] = "You do not have edit permissions"
            redirect_to user_path(current_user)
        end 
    end 
        
end
