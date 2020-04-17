class Ingredient < ActiveRecord::Base
    has_many :cocktail_ingredients
    has_many :cocktails, through: :cocktail_ingredients    

    validates :name, presence: true
    before_save { self.name = name.downcase }


    def self.valid_ingredient(ingredient) # used to validate user cocktail search query to check for valid ingredient. 
        ingredients = ingredient.split(/\W+/) #split ingredient string on any non-word character/blank space
        valid_ingredient = []

        ingredients.each do |i| # iterate through each word in newly created array 
            ingredient = Ingredient.where("name like ?", "%#{i.downcase}%") # locate all ingredient objects where name attribute
            #contains word or partial of it.

            if !ingredient.empty? #if ingredient is not empty add ingredient to calid ingredient array
                valid_ingredient << ingredient
            end 
        end 
          
        if !valid_ingredient.empty? #if no valid ingredients were added to valid_ingredient array return false
            return true
        else 
            return false
        end 
    end

end 

