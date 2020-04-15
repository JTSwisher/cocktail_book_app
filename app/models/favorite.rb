class Favorite < ActiveRecord::Base
    belongs_to :cocktail
    belongs_to :user

    validates :rating, presence: true

end