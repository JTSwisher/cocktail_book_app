class FavoritesController < ApplicationController
    before_action :current_user
    def new
        @favorite = Favorite.new 
        
    end 



end
