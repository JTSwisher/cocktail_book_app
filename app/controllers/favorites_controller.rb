class FavoritesController < ApplicationController
    before_action :current_user
    before_action :require_login
    before_action :favorite_ownership, only: [:edit, :update, :destroy]
    before_action :current_favorite_object, only: [ :show, :edit, :update, :destroy ]

    def index
        if params[:user_id]
            @favorites = current_user.favorites.all
        else 
            @cocktail = Cocktail.find(params[:cocktail_id])
            @favorites = @cocktail.favorites
            render 'index_by_cocktail'
        end 
    end

    def show 
    end 

    def create #Use Cocktail class method to update rating of cocktail after associated favorite has been created
       @favorite_cocktail = @user.favorites.build(favorite_params)
       if @favorite_cocktail.save
            Cocktail.new_favorite_update_average_rating(@favorite_cocktail.cocktail_id, @favorite_cocktail.rating)
            redirect_to user_favorites_path(@user)
       else 
            redirect_to user_favorites_path(@user)
       end
    end 

    def edit
    end 

    def update #Account for difference in rating update for favorite, utilize Cocktail class method accordingly to update cocktail rating overall.
        if @favorite.rating > favorite_params[:rating].to_i
            rating_difference = @favorite.rating - favorite_params[:rating].to_i
            @favorite.update(favorite_params)
            Cocktail.update_rating_reduce(@favorite.cocktail.id, rating_difference)
        else 
            rating_difference = favorite_params[:rating].to_i - @favorite.rating
            @favorite.update(favorite_params)
            Cocktail.update_rating_increase(@favorite.cocktail.id, rating_difference)
        end 
        redirect_to user_favorite_path(@favorite.user, @favorite)
    end 

    def destroy # Use Cocktail class method to update cocktail rating after associated favorite has been deleted. 
        Cocktail.favorite_delete_update_average_rating(@favorite.cocktail.id, @favorite.rating)
        @favorite.destroy
        redirect_to user_favorites_path(current_user)
    end 

private

    def favorite_params
        params.require(:favorite).permit(:user_id, :cocktail_id, :rating, :comments)
    end 

end


