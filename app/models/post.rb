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
  
  # 画像のリサイズ
  def get_post_image(width,height)
    if post_image.attached?
      post_image.variant(resize_to_limit: [width, height]).processed
    end
  end
  
end
