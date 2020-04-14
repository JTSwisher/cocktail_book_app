class CocktailsController < ApplicationController
    before_action :current_user
    
    def index
        if params[:user_id]
            @user = current_user
            @cocktails = @user.cocktails.all
        elsif params[:query]
            if Ingredient.valid_ingredient(params[:query])
                if flash[:alert]
                    flash[:alert].clear
                    @cocktails = Cocktail.find_cocktails_by_ingredient(params[:query])
                else 
                    @cocktails = Cocktail.find_cocktails_by_ingredient(params[:query])
                end 
            else
                flash[:alert] = "No cocktails exist with that ingredient."
                @cocktails = Cocktail.all 
            end 
        else 
            if flash[:alert]
                flash[:alert].clear
                @cocktails = Cocktail.all 
            else 
                @cocktails = Cocktail.all 
            end 
        end 
    end 

    

    def new
        @cocktail = Cocktail.new
        5.times { @cocktail.cocktail_ingredients.build.build_ingredient}
    end 

    def create
        @user = current_user
        @cocktail = @user.cocktails.build(cocktail_params)
       if @cocktail.save 
        redirect_to user_cocktail_path(@user, @cocktail)
       else 
        render 'new'
       end 
    end 

    def show
        @user = current_user
        @favorite = Favorite.new
        @cocktail = current_cocktail
    end 

private 

    def cocktail_params
            params.require(:cocktail).permit(:name, :instructions,
            cocktail_ingredients_attributes: [:quantity,
            ingredient_attributes: [:name]])
    end 


end
