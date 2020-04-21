class FavoritesController < ApplicationController
    before_action :current_user
    before_action :require_login
    before_action :favorite_ownership, only: [:edit, :update, :destroy]
    before_action :current_favorite_object, only: [ :show, :edit, :update, :destroy ]

    def index
        @favorites = current_user.favorites.all 
    end

    def show 
        
    end 

    def create
       @favorite_cocktail = @user.favorites.build(favorite_params)
       if @favorite_cocktail.save
 
            Cocktail.update_average_rating(@favorite_cocktail.cocktail_id, @favorite_cocktail.rating)
            redirect_to user_favorites_path(@user)
       else 
            redirect_to user_favorites_path(@user)
       end
    end 

    def edit
        
    end 

    def update
        @favorite.update(favorite_params)
        redirect_to user_favorite_path(@favorite.user, @favorite)
    end 

    def destroy
        Cocktail.favorite_delete_update_average_rating(@favorite.cocktail.id, @favorite.rating)
        @favorite.destroy
        redirect_to user_favorites_path(current_user)
    end 

private

    def favorite_params
        params.require(:favorite).permit(:user_id, :cocktail_id, :rating, :comments)
    end 

end


