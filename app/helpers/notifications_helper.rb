module NotificationsHelper
  
  # 通知を確認したどうかを判断するメソッド
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
  
end
