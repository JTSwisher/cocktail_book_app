class User < ActiveRecord::Base
    has_many :favorites
    #has_many :cocktails, through: :favorites 
    
    has_many :cocktails
        
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :password, presence: true
    validates :password, confirmation: { case_sensitive: true }

end 