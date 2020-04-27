class Cocktail < ActiveRecord::Base
    belongs_to :user
    has_many :favorites
    has_many :cocktail_ingredients
    has_many :ingredients, through: :cocktail_ingredients
    validates_associated :cocktail_ingredients

    validates :name, presence: true
    validates :instructions, presence: true 
    validates :cocktail_ingredients, presence: true

    accepts_nested_attributes_for :cocktail_ingredients, limit: 5,  :reject_if => proc { |attrs| attrs[:quantity].blank? || attrs[:ingredient_attributes][:name].blank?} #ignore any new record hashes if they fail to pass
    
    scope :highest_rated, -> {where ("average_rating >= 7.0")} 

    def self.user_cocktails_index(user) #queries all cocktails for a  specific user for index view
        @cocktails = user.cocktails.all
    end 

    def self.query_cocktails_index(query) #queries all cocktails for a  specific user search term for index view. Check for valid ingredient -> true -> find_cocktails_by_ingredient
        if Ingredient.valid_ingredient(query)
            @cocktails = Cocktail.find_cocktails_by_ingredient(query)
        end 
    end 

    def self.find_cocktails_by_ingredient(query) 
        ingredients = query.scan(/\w+/) #omit spaces special characters, return whole strings only
        cocktail_ids = []
        
        ingredients.each do |i| #Iterate over each search term
            ingredient = Ingredient.find_ingredient(i.downcase)
            ingredient.each do |o| #Iterate over returned valid ingredients to locate associated cocktail_ingredient objects where ingredient id is present. 
                ids = CocktailIngredient.all.where(ingredient_id: o.id)
            
                ids.each do |c| 
                    cocktail_ids << c.cocktail_id #shovel cocktail_id from favorite object into cocktail_ids array
                end 
            end 
        end 

        @cocktails = Cocktail.all.where(id: cocktail_ids) #locate all cocktails where cocktail_id is present, returns array
        
        if !@cocktails.empty?
            @cocktails
        end 
    end 


    def self.new_favorite_update_average_rating(id, rating) #Updating average_rating, ratings_count and ratings_sum when new favorite object is created for the cocktail. 
		@cocktail = Cocktail.find(id)
        ratings_count = @cocktail.ratings_count + 1
        ratings_sum = @cocktail.ratings_sum + rating
        new_rating = ratings_sum.to_f / ratings_count.to_f
        @cocktail.update(average_rating: new_rating, ratings_count: ratings_count, ratings_sum: ratings_sum)
    end 
    

    def self.favorite_delete_update_average_rating(id, rating) #Updating average_rating for cocktail at the time of associated favorite object being deleted. 
        @cocktail = Cocktail.find(id)
        new_ratings_count = @cocktail.ratings_count - 1
        if new_ratings_count == 0 #if cocktail has been favorited only once at this point reset all values to zero. 
            new_ratings_sum = 0
            new_average = 0
            @cocktail.update(average_rating: new_average, ratings_sum: new_ratings_sum, ratings_count: new_ratings_count)
        else 
            new_ratings_sum = @cocktail.ratings_sum - rating
            new_average = new_ratings_sum / new_ratings_count
            @cocktail.update(average_rating: new_average, ratings_sum: new_ratings_sum, ratings_count: new_ratings_count)
        end 
    end 

    def self.update_rating_reduce(id, rating) #Updating average rating for cocktail at the time of associated favorite objects rating decreasing.
        @cocktail = Cocktail.find(id)
        new_ratings_sum = @cocktail.ratings_sum - rating
        new_average = new_ratings_sum / @cocktail.ratings_count
        @cocktail.update(average_rating: new_average, ratings_sum: new_ratings_sum)
    end 

    def self.update_rating_increase(id, rating) #Updating average rating for cocktail at the time of associated favorite objects rating increasing.
        @cocktail = Cocktail.find(id)
        new_ratings_sum = @cocktail.ratings_sum + rating
        new_average = new_ratings_sum / @cocktail.ratings_count
        @cocktail.update(average_rating: new_average, ratings_sum: new_ratings_sum)
    end 
    
    
end 