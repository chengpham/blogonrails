class Comment < ApplicationRecord
  belongs_to :post
  validates :body, presence: {message: 'must be provided'}
end
