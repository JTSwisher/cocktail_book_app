class CocktailsController < ApplicationController

    def new
        @cocktail = Cocktail.new
        5.times { @cocktail.cocktail_ingredients.build.build_ingredient}
    end 

    def create
        @user = User.find_by(id: session[:user_id])
        @cocktail = Cocktail.create(cocktail_params)
        @user.cocktails.build(@cocktail)
        redirect_to user_cocktail_path(@user, @cocktail)
    end 

private 

    def cocktail_params
            params.require(:cocktail).permit(:name, :instructions,
            :cocktail_ingredients_attributes => [:quantity,
            :ingredient_attributes => [:name]])
    end 


end
