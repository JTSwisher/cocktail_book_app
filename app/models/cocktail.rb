class Cocktail < ActiveRecord::Base
    belongs_to :user
    has_many :cocktail_ingredients
    has_many :ingredients, through: :cocktail_ingredients

    validates :name, presence: true
    validates :instructions, presence: true 

    accepts_nested_attributes_for :cocktail_ingredients, :reject_if => proc { |attrs| attrs[:quantity].blank? && attrs[:ingredient_attributes][:name].blank?}
       
    

end 