class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  # 新規登録で引っかかる
  # validates :profile, length: { minimum: 1, maximum: 100 }

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

  # フォローしたとき
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すとき
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  
  # 部分一致検索の条件
  def self.partial_search(word)
    where("name LIKE?", '%'+word+'%')
  end
  
end
