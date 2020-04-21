class TopCocktail < ActiveRecord::Base
    belongs_to :cocktail
    scope :highest_rated, -> {where ("average_rating >= 7.0")}

   
 def self.create_update_top_cocktail(cocktail_id, rating)
    if @top_cocktail =  TopCocktail.find_by(cocktail_id: cocktail_id)
        ratings_count = @top_cocktail.ratings_count + 1
        ratings_sum = @top_cocktail.ratings_sum + rating
        new_rating = ratings_sum / ratings_count
        @top_cocktail.update(average_rating: new_rating, ratings_count: ratings_count, ratings_sum: ratings_sum)

    else
        TopCocktail.create(cocktail_id: cocktail_id, average_rating: rating , ratings_sum: rating, ratings_count: 1)
    end
end


    def self.destroy_top_cocktail(cocktail_id)
        #Called when cocktail object is deleted. Find top_cocktail object associated wtih cocktail and destroy.
        if @top_cocktail = TopCocktail.find_by(cocktail_id: cocktail_id)
            @top_cocktail.destroy
        end 
    end 

    def self.update_top_cocktail(cocktail_id, rating)
        # Used to update topcocktail when favorite_object is removed from users favorites. If top cocktail has only one rating destroy. 
        #Otherwise reduce rating count by 1, reduce ratings_sum by favorite_object rating. Recalculate top_cocktail object average rating. 
        @top_cocktail = TopCocktail.find_by(cocktail_id: cocktail_id)
        if @top_cocktail.ratings_count == 1
            @top_cocktail.destroy
        else 
            new_ratings_count = @top_cocktail.ratings_count - 1
            new_ratings_sum = @top_cocktail.ratings_sum - rating
            new_average = new_ratings_sum / new_ratings_count
            @top_cocktail.update(average_rating: new_average, ratings_sum: new_ratings_sum, ratings_count: new_ratings_count)
        end 
    end 

   

end 