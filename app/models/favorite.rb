class Favorite < ActiveRecord::Base
    belongs_to :cocktail
    belongs_to :user


    def self.average_rating(cocktail)
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

    def self.rating_count(cocktail)
        ratings = []

        if cocktail != ""
            cocktails = Favorite.all.where(cocktail_id: cocktail)

            cocktails.each do |cr|
                ratings << cr.rating
            end

            ratings.count
        end 
    end 



end