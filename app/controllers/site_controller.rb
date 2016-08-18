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
      @result = Friend.add_friend(params[:userId], current_user.id)
      if @result
        render json: @result
      end
    end
  end

  # ajax unfiend
  def un_request
    if params[:userId].present?
      @result = Friend.un_request(params[:userId], current_user.id)
      if @result
        render json: @result
      end
    end
  end

  def un_friend
    if params[:userId].present?
      @result = Friend.un_friend(params[:userId], current_user.id)
      if @result
        render json: @result
      end
    end
  end

#   ajax add favorite
  def add_favorite
    if params[:userId].present?
      @result = Friend.add_favorite(params[:userId], current_user.id)
      if @result
        render json: @result
      end
    end
  end

#   ajax add favorite
  def un_favorite
    if params[:userId].present?
      @result = Friend.un_favorite(params[:userId], current_user.id)
      if @result
        render json: @result
      end
    end
  end

#   ajax accept friend
  def accept_friend
    if params[:userId].present?
      @result = Friend.accept_friend(params[:userId], current_user.id)
      if @result
        render json: @result
      end
    end
  end

  def deny_request
    if params[:userId].present?
      @result = Friend.deny_friend(params[:userId], current_user.id)
      if @result
        render json: @result
      end
    end
  end
end
