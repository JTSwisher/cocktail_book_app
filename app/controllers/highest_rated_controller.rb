class HighestRatedController < ApplicationController

    def index
        if !Cocktail.highest_rated
        else 
            @cocktails = Cocktail.highest_rated
        end 
    end 



end 