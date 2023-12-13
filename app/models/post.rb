class Post < ApplicationRecord

  # 画像の添付
  has_one_attached :post_image

  # アソシエーション
  belongs_to :category
  belongs_to :user

  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy

  has_many :notifications, dependent: :destroy

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

  #いいねされているかどうかの判断（通知機能）
  def create_notification_post_like(current_user)
    # すでにいいねされているかどうかの判断
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user.id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'post_like'
        )
        # 自分の投稿に対してのいいねは通知済み
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
      notification.save if notification.valid?
    end
  end

  # コメントの通知を送るユーザの判別
  def create_notification_post_comment(current_user, post_comment_id)
    # 投稿にコメントしているユーザーを保存（自分以外）
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_comment(current_user, post_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントされていない場合の通知
    save_notification_post_comment(current_user, post_comment_id, user_id) if temp_ids.blank?
  end
    # 上記の情報保存アクション
    def save_notification_post_comment(current_user, post_comment_id, visited_id)
      notification = current_user.active_notifications.new(
        post_id: id,
        post_comment_id: post_comment_id,
        visited_id: visited_id,
        action: 'post_comment'
        )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end

end
