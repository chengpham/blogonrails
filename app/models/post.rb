class Post < ApplicationRecord
    belongs_to :user, optional: true
    has_many :comments, dependent: :destroy
    validates :title, presence: {message: 'must be provided'}, uniqueness: true
    validates :body, presence: true, length:{minimum: 50}

end
