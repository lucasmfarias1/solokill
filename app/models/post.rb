class Post < ApplicationRecord
  belongs_to :user
  belongs_to :parent,
             :class_name => 'Post',
             :foreign_key => 'parent_id',
              optional: true
              
  has_many :children, :class_name => 'Post', :foreign_key => 'parent_id'
  validates :content, length: { minimum: 1, maximum: 240 }
end
