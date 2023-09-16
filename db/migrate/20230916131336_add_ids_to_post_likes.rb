class AddIdsToPostLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :post_likes, :user_id, :integer
    add_column :post_likes, :post_id, :integer
  end
end
