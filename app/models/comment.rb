class Comment < ApplicationRecord
  belongs_to :post
  validates :post_id, presence: true
  validates :commenter, presence: true
  validates :body, presence: true, length: { maximum: 140 }
end


