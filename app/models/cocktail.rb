class Cocktail < ActiveRecord::Base
    belongs_to :user
    has_many :top_cocktails
    has_many :cocktail_ingredients
    has_many :ingredients, through: :cocktail_ingredients
    validates_associated :cocktail_ingredients

    validates :name, presence: true
    validates :instructions, presence: true 
    validates :cocktail_ingredients, presence: true

    accepts_nested_attributes_for :cocktail_ingredients, limit: 5,  :reject_if => proc { |attrs| attrs[:quantity].blank? || attrs[:ingredient_attributes][:name].blank?}
    


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

    def self.user_cocktails_index(user)
        @cocktails = user.cocktails.all
    end 

    def self.query_cocktails_index(query)
        if Ingredient.valid_ingredient(query)
            @cocktails = Cocktail.find_cocktails_by_ingredient(query)
        end 
    end 


end 