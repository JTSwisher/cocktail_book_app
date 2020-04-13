class CocktailsController < ApplicationController
    before_action :current_user

    def index
        if params[:user_id]
            @user = current_user
            @cocktails = @user.cocktails.all
        else
            @cocktails = Cocktail.all 
        end 
    end 

    def new
        @cocktail = Cocktail.new
        2.times { @cocktail.cocktail_ingredients.build.build_ingredient}
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
        @cocktail = Cocktail.find_by(id: params[:id])
    end 

private 

    def cocktail_params
            params.require(:cocktail).permit(:name, :instructions,
            cocktail_ingredients_attributes: [:quantity,
            ingredient_attributes: [:name]])
    end 


end
