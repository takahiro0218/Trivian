class Post < ApplicationRecord
  
  # 画像の添付
  has_one_attached :post_image
  
  # アソシエーション
  belongs_to :category
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  
  
  # バリデーション
  validates :text, presence: true
  
end
