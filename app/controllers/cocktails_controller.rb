class CocktailsController < ApplicationController

    def new
        @cocktail = Cocktail.new
        5.times { @cocktail.cocktail_ingredients.build.build_ingredient}
    end 

    def create
        raise cocktail_params.inspect
    end 



end
