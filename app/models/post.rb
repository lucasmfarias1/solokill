class Post < ApplicationRecord
  after_create_commit { PostBroadcastJob.perform_later self }

  belongs_to :user
  belongs_to :parent,
             :class_name => 'Post',
             :foreign_key => 'parent_id',
              optional: true

  has_many :children, :class_name => 'Post', :foreign_key => 'parent_id'
  validates :content, presence: true, length: { minimum: 1, maximum: 240 }
end
