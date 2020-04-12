class CocktailsController < ApplicationController

    def new
        @cocktail = Cocktail.new
        5.times { @cocktail.cocktail_ingredients.build.build_ingredient}
    end 

    def create
        raise cocktail_params.inspect
        @user = User.find(id: session[:user_id])
    end 

private 

    def cocktail_params
            params.require(:cocktail).permit(:name, :instructions,
            :cocktail_ingredients_attributes => [:quantity,
            :ingredient_attributes => [:name]])
    end 


end
