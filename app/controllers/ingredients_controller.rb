class IngredientsController < ApplicationController

    def new
        @ingredient = Ingredient.new
    end 


    def create 
        raise params.inspect
    end 
end
