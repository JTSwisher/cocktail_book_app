class FavoritesController < ApplicationController
    before_action :current_user
    before_action :current_cocktail

    def index
        @favorites = current_user.favorites.all
    end
    
    def new
        @cocktail = current_cocktail
        @favorite = Favorite.new 
    end 

    def show 
        @favorite = Favorite.find_by(id: params[:id])
    end 

    def create
       @user = current_user
       @favorite_cocktail = @user.favorites.build(favorite_params)
       if @favorite_cocktail.save
            redirect_to user_favorite_path(@user, @favorite_cocktail)
       else 

       end
    end 

private

    def favorite_params
        params.require(:favorite).permit(:user_id, :cocktail_id, :rating, :comments)
    end 

end
