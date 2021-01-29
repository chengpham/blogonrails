class User < ApplicationRecord
    has_many :posts, dependent: :nullify
    has_many :coments, dependent: :nullify
    has_secure_password
    validates :name, presence: {message: "should be present."}
    validates :email, presence: true, uniqueness: true

    def full_name
        "#{self.name}".strip.titleize
    end
    # def full_name
    #     "#{self.name}".split.map(&:capitalize).join(' ')
    # end
end
