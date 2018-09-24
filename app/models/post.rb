class Post < ApplicationRecord
  belongs_to :user
  validates :content, length: { minimum: 1, maximum: 240 }
end
