module FavoritesHelper

    def average_rating(cocktail)
        ratings = []

        if cocktail != ""
            cocktails = Favorite.all.where(cocktail_id: cocktail)

            cocktails.each do |c|
                ratings << c.rating
            end 
            #This implementation works as well, much longer
            #rating = ratings.inject{ |sum, el| sum + el }.to_f / ratings.size 
            
            rating = ratings.sum(0.0) / ratings.size
            rating
        else
           puts  "Not Rated"
        end 
    end 



    def rating_count(cocktail)
        ratings = []

        if cocktail != ""
            cocktails = Favorite.all.where(cocktail_id: cocktail)

            cocktails.each do |cr|
                ratings << cr.rating
            end

            ratings.count
        end 
    end 

    def highest_rated_cocktails(favorite)
        favorite_cocktail = Cocktail.find_by(id: favorite.cocktail.id)
        favorite_cocktail
    end 
end
