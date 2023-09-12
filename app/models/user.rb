class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  
  # バリデーション
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :profile, length: { minimum: 1, maximum: 100 }
  
  # 画像の添付
  has_one_attached :user_image
  
  # ユーザ画像のリサイズとNO_IMAGE
  def get_user_image(width,height)
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
