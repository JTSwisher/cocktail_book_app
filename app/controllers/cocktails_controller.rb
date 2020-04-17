class CocktailsController < ApplicationController
    before_action :current_user
    before_action :require_login
    before_action :current_cocktail
    before_action :cocktail_ownership, only: [:edit, :destroy, :update]
    
    def index
        if params[:user_id]
            @cocktails = Cocktail.user_cocktails_index(current_user)
        elsif params[:query]
            @cocktails = Cocktail.query_cocktails_index(params[:query]) 
        else 
             @cocktails = Cocktail.all 
        end 
    end 

    

    def new
        @cocktail = Cocktail.new
        5.times { @cocktail.cocktail_ingredients.build.build_ingredient}
    end 

    def create
        @cocktail = @user.cocktails.build(cocktail_params)
        if @cocktail.save 
            redirect_to user_cocktail_path(@user, @cocktail)
        else 
            render 'new'
        end 
    end 

    def show
        @favorite = Favorite.new
    end 

    def edit
        count = @cocktail.cocktail_ingredients.size
        if count < 5
            available_ingredients = 5 - count
            available_ingredients.times {@cocktail.cocktail_ingredients.build.build_ingredient}
        end
    end 

    def update
        @cocktail.update(cocktail_params)
        redirect_to user_cocktail_path(@cocktail.user.id, @cocktail) 
        #creates all new objects for ingredients after updating not the newly added ingredients or newl changed
    end 

    def destroy
        destroy_favorites(@cocktail.id)
        @cocktail.destroy
        redirect_to user_cocktails_path(current_user)
    end 

private 

    def cocktail_params
            params.require(:cocktail).permit(:name, :instructions,
            cocktail_ingredients_attributes: [:id, :quantity,
            ingredient_attributes: [:name]])
    end 


end
