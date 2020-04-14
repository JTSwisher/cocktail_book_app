class Ingredient < ActiveRecord::Base
    has_many :cocktail_ingredients
    has_many :cocktails, through: :cocktail_ingredients    

    validates :name, presence: true

    def self.valid_ingredient(ingredient)
        if  Ingredient.find_by(name: ingredient)
            return true
        end 
    end

end 