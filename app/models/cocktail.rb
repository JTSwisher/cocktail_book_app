class Cocktail < ActiveRecord::Base
    belongs_to :user
    has_many :cocktail_ingredients
    has_many :ingredients, through: :cocktail_ingredients
    validates_associated :cocktail_ingredients

    validates :name, presence: true
    validates :instructions, presence: true 
    validates :cocktail_ingredients, presence: true

    accepts_nested_attributes_for :cocktail_ingredients, limit: 5,  :reject_if => proc { |attrs| attrs[:quantity].blank? || attrs[:ingredient_attributes][:name].blank?}
    scope :highest_rated, -> {where ("average_rating >= 7.0")}


    def self.find_cocktails_by_ingredient(query)
        ingredients = query.split(/\W+/)
        cocktail_ids = []
        ingredient_ids = []

        ingredients.each do |i|
            ingredient = Ingredient.where("name like ?", "%#{i.downcase}%")
            ingredient.each do |i|
                ids = CocktailIngredient.all.where(ingredient_id: i.id)
                ids.each do |i|
                    ingredient_ids << i.cocktail_id
                end 
            end 
        end 

        ingredient_ids.each do |ci|
            cocktail_ids << ci
        end 

        @cocktails = Cocktail.all.where(id: cocktail_ids)

        if !@cocktails.empty?
            @cocktails
        else 
            @cocktails = Cocktail.all
        end 
    end 

    def self.user_cocktails_index(user) #queries all cocktails fora  specific user for index
        @cocktails = user.cocktails.all
    end 

    def self.query_cocktails_index(query) #queries all cocktails for a  specific usearch term
        if Ingredient.valid_ingredient(query)
            @cocktails = Cocktail.find_cocktails_by_ingredient(query)
        end 
    end 


    def self.update_average_rating(id, rating) #Updating average_rating, ratings_count and ratings_sum when new favorite object is created for the cocktail. 
		@cocktail = Cocktail.find(id)
        ratings_count = @cocktail.ratings_count + 1
        ratings_sum = @cocktail.ratings_sum + rating
        new_rating = ratings_sum.to_f / ratings_count.to_f
        @cocktail.update(average_rating: new_rating, ratings_count: ratings_count, ratings_sum: ratings_sum)
    end 
    

    def self.favorite_delete_update_average_rating(id, rating)
        @cocktail = Cocktail.find(id)
        new_ratings_count = @cocktail.ratings_count - 1
        if new_ratings_count == 0 
            new_ratings_sum = 0
            new_average = 0
            @cocktail.update(average_rating: new_average, ratings_sum: new_ratings_sum, ratings_count: new_ratings_count)
        else 
            new_ratings_sum = @cocktail.ratings_sum - rating
            new_average = new_ratings_sum / new_ratings_count
            @cocktail.update(average_rating: new_average, ratings_sum: new_ratings_sum, ratings_count: new_ratings_count)
        end 
    end 


    
end 