class TopCocktailsController < ApplicationController

    def index
        if !TopCocktail.highest_rated
        else
            @favorites = TopCocktail.highest_rated
        end 
    end

end 