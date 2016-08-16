module ApplicationHelper
  def get_status_friend (friend_user_id)
    @data = current_user.friends.where(["friend_user_id = ?","#{friend_user_id}"]).first
    # binding.pry
  end

end
