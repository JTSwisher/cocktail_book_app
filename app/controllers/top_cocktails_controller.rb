class TopCocktailsController < ApplicationController

    def index
        if !TopCocktail.highest_rated
        else
            @top_cocktails = TopCocktail.highest_rated
        end 
    end

end 