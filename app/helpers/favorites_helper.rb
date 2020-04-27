module FavoritesHelper

    def highest_rated_cocktails(favorite)
        # using favorite object to locate associated cocktail to display in user favorites index view
        favorite_cocktail = Cocktail.find(favorite.cocktail_id)
    end 


    def favorites_rating(c)
       #given ratings for a specified cocktail if above zero render rating else render "not rated"
        cocktail = highest_rated_cocktails(c)
        if cocktail.ratings_count > 0 
            content_tag :td, "#{cocktail.average_rating} / 10"
        else
            tag.td 'Not Rated'
        end

    end 

    def user_favorite(user, cocktail)
        # using boolean value based on user ownership of cocktail in favorites to advise of favorite ownership cocktail show view
        if !!user.favorites.find_by(cocktail_id: cocktail.id)
            return true
        else
            return false 
        end 
    end 


end
