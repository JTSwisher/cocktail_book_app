module FavoritesHelper

    def average_rating(cocktail)
        # use cocktail object to find all associated favorite objects where cocktail id is present. Iterate over all
        #favorite objects to pull rating and store in array. Call sum on array and divide size of array. 
        ratings = []

        if cocktail != ""
            cocktail_favorites= Favorite.all.where(cocktail_id: cocktail)

            cocktail_favorites.each do |c|
                ratings << c.rating
            end 
            #This implementation works as well, much longer
            #rating = ratings.inject{ |sum, el| sum + el }.to_f / ratings.size 
            
            rating = ratings.sum(0.0) / ratings.size
            rating
        end 
    end 

    def rating_count(cocktail)
        #use cocktail object to find all associated favorite objects where cocktail id is present. Iterate over all
        #favorite objects to pull rating and store in array call size on array
        ratings = []

        if cocktail != ""
            cocktail_favorites = Favorite.all.where(cocktail_id: cocktail)

            cocktail_favorites.each do |cr|
                ratings << cr.rating
            end

            ratings.size
        end 
    end 

    def highest_rated_cocktails(favorite)
        # using favorite object to locate associated cocktail to display in view
        favorite_cocktail = Cocktail.find(favorite.cocktail_id)
        
        favorite_cocktail
    end 


    def favorites_rating(c)
        #using rating_count helper to generate number of given ratings for a specified cocktail if above
        # zero render rating else render "not rated"
        cocktail = highest_rated_cocktails(c)
        if rating_count(cocktail.id) > 0 
            content_tag :td, "#{average_rating(cocktail.id)} / 10"
        else
            tag.td 'Not Rated'
        end

    end 

    def user_favorite(user, cocktail)
        # using bolloean value based on user ownership of cocktail in favorites to adjust cocktail show view
        if !!user.favorites.find_by(cocktail_id: cocktail.id)
            return true
        else
            return false 
        end 
    end 

end
