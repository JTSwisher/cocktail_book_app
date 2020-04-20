class TopCocktail < ActiveRecord::Base
    belongs_to :cocktail
    scope :highest_rated, -> {where ("average_rating >= 7.0")}

    def self.update_average_rating(cocktail_id, rating)
        if @top_cocktail =  TopCocktail.find_by(cocktail_id: cocktail_id)
            ratings_count = @top_cocktail.ratings_count + 1
            ratings_sum = @top_cocktail.ratings_sum + rating
            new_rating = ratings_sum / ratings_count
            @top_cocktail.update(average_rating: new_rating, ratings_count: ratings_count, ratings_sum: ratings_sum)

        else
            TopCocktail.create(cocktail_id: cocktail_id, average_rating: rating , ratings_sum: rating, ratings_count: 1)
        end
    end



end 