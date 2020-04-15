class FavoritesController < ApplicationController
    before_action :current_user
    before_action :current_cocktail

    def index
        if params[:user_id]
            @favorites = current_user.favorites.all
        else 
            @favorites = Favorite.highest_rated
        end 
    end
    
    def new
        @cocktail = current_cocktail
        @favorite = Favorite.new 
    end 

    def show 
        @favorite = Favorite.find_by(id: params[:id])
        @cocktail = current_cocktail
    end 

    def create
       @user = current_user
       @favorite_cocktail = @user.favorites.build(favorite_params)
       if @favorite_cocktail.save
            redirect_to user_favorites_path(@user)
       else 

       end
    end 

    def edit
        @cocktail = current_cocktail
        @favorite = Favorite.find_by(id: params[:id])
    end 

private

    def favorite_params
        params.require(:favorite).permit(:user_id, :cocktail_id, :rating, :comments)
    end 

end
