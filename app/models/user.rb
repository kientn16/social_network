class User < ActiveRecord::Base
  has_one :point, :class_name => 'Point'
  delegate :point, to: :point, prefix: true, allow_nil: true
  has_many :friends
  # validate :password_complexity

  validates_presence_of :name, :email, :address, :phone
  validates_presence_of :password, :on => :create
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :name, :email
  validates :password, password_strength: true
  # upload image
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150>" }, default_url: "http://yantrahub.com/news/wp-content/uploads/2016/07/icon-user-default-150x150.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  # authen password
  has_secure_password

  # def password_complexity
  #   return if password.nil?
  #
  #   if password.size < 8
  #     errors.add :password, "Must be at least 8 characters long."
  #     return
  #   end
  #
  # end

  def self.search(params)
    if params[:key_word]
      @search_keyword = ["name LIKE ? OR address LIKE ? OR phone LIKE ? OR email LIKE ?", "%#{params[:key_word].strip}%", "%#{params[:key_word].strip}%", "%#{params[:key_word].strip}%", "%#{params[:key_word].strip}%"]
      case params[:sort]
        when "friends"
          users = User.joins("LEFT JOIN friends FL ON users.id = FL.user_id
                              LEFT JOIN friends FL2 ON
                              FL.friend_user_id = FL2.user_id AND FL2.friend_user_id = users.id
                    WHERE (name LIKE '%#{params[:key_word].strip}%' OR address LIKE '%#{params[:key_word].strip}%' OR phone LIKE '%#{params[:key_word].strip}%' OR email LIKE '%#{params[:key_word].strip}%')
                           GROUP BY users.id ORDER BY COUNT(DISTINCT FL2.id) #{params[:order]}
                             ")

        when "favorites"
          @condition = "ORDER BY p.point #{params[:order]}"
          users = User.joins("LEFT JOIN points p ON p.user_id = users.id WHERE (name LIKE '%#{params[:key_word].strip}%' OR address LIKE '%#{params[:key_word].strip}%' OR phone LIKE '%#{params[:key_word].strip}%' OR email LIKE '%#{params[:key_word].strip}%')
                               #{@condition} ")
        when "name"
          users = User.all
          users = users.where(@search_keyword) if params[:key_word].present?
          users = users.order("users.name #{params[:order]}")
        when "created_at"
          users = User.all
          users = users.where(@search_keyword) if params[:key_word].present?
          users = users.order("users.created_at #{params[:order]}")
      end
      return users
    else
      User.all.order("id DESC")
    end
  end

  def get_invite_by_frient_id (user_id,user_friend_id)
    friend = Friend.where("user_id = #{user_id} AND friend_user_id = #{user_friend_id}").first
    return friend
  end

  def get_total_friend (user_id)
    Friend.where("user_id = #{user_id} AND is_friend = 1")
  end


end
