class HighestRatedController < ApplicationController

def index
    @cocktails = Cocktail.highest_rated
end 

end 