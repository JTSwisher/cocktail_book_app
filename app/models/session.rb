class Session < ActiveRecord:Base
    has_secure_password
    validates :email, presence: true
    
    validates :password, presence: true
    validates :password, confirmation: { case_sensitive: true }


end 