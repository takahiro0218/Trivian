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
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  # いいねしているかどうかの判別
  def post_liked_by?(user)
   post_likes.exists?(user_id: user.id)
  end

  # 部分一致検索の条件
  def self.partial_search(word)
    if word.present?
      where("text LIKE ?", '%' + word + '%')
    else
      none
    end
  end

end
