class SiteController < ApplicationController
  def index
    @users = User.search(params).paginate(:page => params[:page], :per_page => 5)
    @search = params || {}
  end

  def check_data_friend (id)
      current_user.friends.where(["friend_user_id = ?","#{id}"]).first
  end


#   ajax add friend
  def add_friend
    if params[:userId].present?
      @friend = Friend.where(:user_id => current_user.id, :friend_user_id => params[:userId], :is_request_friend => 0).first
      if @friend
        @friend.update(:is_request_friend => 1)
        render json: @friend
      else
        @friend = Friend.new(:user_id => current_user.id, :friend_user_id => params[:userId], :is_request_friend => 1)
        if @friend.save
          render json: @friend
        end
      end
    end
  end

  # ajax unfiend
  def un_request
    if params[:userId].present?
      @friend = Friend.where(:user_id => current_user.id, :friend_user_id => params[:userId], :is_request_friend => 1).first
      # render json: @friend
      if @friend.update(:user_id => current_user.id, :friend_user_id => params[:userId], :is_request_friend => 0)
        render json: @friend
      end
    end
  end

  def un_friend
    if params[:userId].present?
      @friend = Friend.where(:user_id => current_user.id, :friend_user_id => params[:userId], :is_friend => 1).first
      # binding.pry
      if @friend.update(:is_request_friend => 0, :is_friend => 0)
        render json: @friend
      end

      @friend2 = Friend.where(:friend_user_id => current_user.id, :user_id => params[:userId], :is_friend => 1).first
      if @friend2.update(:is_request_friend => 0, :is_friend => 0)
        render json: @friend2
      end
    end
  end

#   ajax add favorite
  def add_favorite
    if params[:userId].present?
      @friend = Friend.where(:user_id => current_user.id, :friend_user_id => params[:userId]).first
      if @friend
        @friend.update(:is_favorite => 1)
        Point.update_point(params[:userId])
        render json: @friend
      else
        @friend = Friend.new(:user_id => current_user.id, :friend_user_id => params[:userId], :is_favorite => 1)
        # add pont
        Point.update_point(params[:userId])
        if @friend.save
          render json: @friend
        end
      end
    end
  end

#   ajax add favorite
  def un_favorite
    if params[:userId].present?
      @friend = Friend.where(:user_id => current_user.id, :friend_user_id => params[:userId]).first
      if @friend
        @friend.update(:is_favorite => 0)
        render json: @friend
      end
    end
  end

#   ajax accept friend
  def accept_friend

    if params[:userId].present?
      @friend = Friend.where(:user_id => params[:userId], :friend_user_id => current_user.id).first
      @friend2 = Friend.where(:friend_user_id => params[:userId], :user_id => current_user.id).first
      # binding.pry
      if @friend
        @friend.update(:is_friend => 1, :is_request_friend => 0)
        if @friend2
          @friend2.update(:is_friend => 1, :is_request_friend => 0)
        else
          friend = Friend.new(:user_id => current_user.id, :friend_user_id => params[:userId], :is_friend => 1)
          friend.save
        end
        render json: @friend
      end
    end
  end

  def deny_request
    if params[:userId].present?
      @friend = Friend.where(:friend_user_id => current_user.id, :user_id => params[:userId], :is_request_friend => 1).first
      # render json: @friend
      if @friend.update(:is_request_friend => 0)
        render json: @friend
      end
    end
  end
end
