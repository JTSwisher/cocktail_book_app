class CocktailsController < ApplicationController
    before_action :current_user
    before_action :current_cocktail
    
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

    def edit
        @cocktail = current_cocktail
        count = @cocktail.cocktail_ingredients.size
        if count < 5
            available_ingredients = 5 - count
            available_ingredients.times {@cocktail.cocktail_ingredients.build.build_ingredient}
        end
    end 

    def update
        @cocktail = current_cocktail
        @cocktail.update(cocktail_params)
        redirect_to user_cocktail_path(@cocktail.user.id, @cocktail) 
        #creates all new objects for ingredients after updating not the newly added ingredients or newl changed
    end 

    def destroy
        @cocktail = current_cocktail
        destroy_favorites(@cocktail.id)
        @cocktail.destroy
        redirect_to user_cocktails_path(current_user)
    end 

private 

    def cocktail_params
            params.require(:cocktail).permit(:name, :instructions,
            cocktail_ingredients_attributes: [:id, :quantity,
            ingredient_attributes: [:id, :name]])
    end 


end
