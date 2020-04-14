class Ingredient < ActiveRecord::Base
    has_many :cocktail_ingredients
    has_many :cocktails, through: :cocktail_ingredients    

    validates :name, presence: true
    before_save { self.name = name.downcase }

    def self.valid_ingredient(ingredient)
        if  Ingredient.find_by(name: ingredient.downcase)
            return true
        end 
    end

end 