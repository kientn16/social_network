class User < ActiveRecord::Base

  has_many :friends

  validates_presence_of :name, :email, :address, :phone
  validates_presence_of :password, :on => :create
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :name, :email

  # upload image
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150>" }, default_url: "http://yantrahub.com/news/wp-content/uploads/2016/07/icon-user-default-150x150.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  # authen password
  has_secure_password

  def self.search(params)
    if params[:key_word]
      users = User.all
      users = users.where(["name LIKE ? OR address LIKE ? OR phone LIKE ? OR email LIKE ?",
                                     "%#{params[:key_word].strip}%","%#{params[:key_word].strip}%","%#{params[:key_word].strip}%","%#{params[:key_word].strip}%"]) if params[:key_word].present?
      # binding.pry
      # categories = categories.where(["address LIKE = ?","%#{params[:key_word]}%"]) if params[:key_word].present?
      # categories = categories.where(["phone LIKE = ?","%#{params[:key_word]}%"]) if params[:key_word].present?
      # categories = categories.where(["email LIKE = ?","%#{params[:key_word]}%"]) if params[:key_word].present?
      return users
    else
      User.all
    end
  end

  def get_invite_by_frient_id (user_id,user_friend_id)
    friend = Friend.where("user_id = #{user_id} AND friend_user_id = #{user_friend_id}").first
    # binding.pry
    return friend
    # if !friend.nil?
    #   return friend
    # else
    #   ni
    # end
  end

end
