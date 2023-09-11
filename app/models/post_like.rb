class PostLike < ApplicationRecord
  
  # アソシエーション
  belongs_to :post
  belongs_to :user
end
