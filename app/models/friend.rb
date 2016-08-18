class Friend < ActiveRecord::Base

  belongs_to :user, class_name: User, foreign_key: :user_id
  belongs_to :user_friend, class_name: User, foreign_key: :friend_user_id

  def self.add_friend (user_id,current_id)
    @friend = self.where(:user_id => current_id, :friend_user_id => user_id, :is_request_friend => 0).first
    if @friend
      @friend.update(:is_request_friend => 1)
      return @friend
    else
      @friend = self.new(:user_id => current_id, :friend_user_id => user_id, :is_request_friend => 1)
      if @friend.save
        return @friend
      end
    end
  end

  def self.un_request (user_id,current_id)
    @friend = self.where(:user_id => current_id, :friend_user_id => user_id, :is_request_friend => 1).first
    # render json: @friend
    if @friend.update(:user_id => current_id, :friend_user_id => user_id, :is_request_friend => 0)
      return @friend
    end
  end

  def self.un_friend (user_id, current_id)
    @friend = self.where(:user_id => current_id, :friend_user_id => user_id, :is_friend => 1).first
    # binding.pry
    if @friend.update(:is_request_friend => 0, :is_friend => 0)
      return @friend
    end

    @friend2 = self.where(:friend_user_id => current_id, :user_id => user_id, :is_friend => 1).first
    if @friend2.update(:is_request_friend => 0, :is_friend => 0)
      return @friend2
    end
  end

  def self.add_favorite(user_id,current_id)
    @friend = self.where(:user_id => current_id, :friend_user_id => user_id).first
    if @friend
      @friend.update(:is_favorite => 1)
      Point.update_point(user_id)
      return @friend
    else
      @friend = self.new(:user_id => current_id, :friend_user_id => user_id, :is_favorite => 1)
      # add pont
      Point.update_point(user_id)
      if @friend.save
        return @friend
      end
    end
  end

  def self.un_favorite(user_id,current_id)
    @friend = self.where(:user_id => current_id, :friend_user_id => user_id).first
    if @friend
      @friend.update(:is_favorite => 0)
      return @friend
    end
  end

  def self.accept_friend(user_id, current_id)
    @friend = self.where(:user_id => user_id, :friend_user_id => current_id).first
    @friend2 = self.where(:friend_user_id => user_id, :user_id => current_id).first
    # binding.pry
    if @friend
      @friend.update(:is_friend => 1, :is_request_friend => 0)
      if @friend2
        @friend2.update(:is_friend => 1, :is_request_friend => 0)
      else
        friend = self.new(:user_id => current_id, :friend_user_id => user_id, :is_friend => 1)
        friend.save
      end
      return @friend
    end
  end

  def self.deny_friend(user_id, current_id)
    @friend = self.where(:friend_user_id => current_id, :user_id => user_id, :is_request_friend => 1).first
    # render json: @friend
    if @friend.update(:is_request_friend => 0)
      return @friend
    end
  end
end
