class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true

    def full_name
        "#{first_name} #{last_name}"
    end
end
