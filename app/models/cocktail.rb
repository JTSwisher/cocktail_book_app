class Cocktail < ActiveRecord::Base
    belongs_to :user
    has_many :cocktail_ingredients
    has_many :ingredients, through: :cocktail_ingredients

    validates :name, presence: true
    validates :instructions, presence: true 

    accepts_nested_attributes_for :cocktail_ingredients, :reject_if => proc { |attrs| attrs[:quantity].blank? && attrs[:ingredient_attributes][:name].blank?}
    
    
    def self.find_cocktails_by_ingredient(query)
        cocktail_ids = []

        if query != "" && Ingredient.valid_ingredient(query)
            ingredient = Ingredient.find_by(name: query.downcase)
            
            ids = CocktailIngredient.all.where(ingredient_id: ingredient.id)
            
            ids.each do |i|
                cocktail_ids << i.cocktail_id
            end 

            @cocktails = Cocktail.all.where(id: cocktail_ids)
        else
            @cocktails = Cocktail.all
        end 
    end 


end 