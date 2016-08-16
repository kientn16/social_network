class SiteController < ApplicationController
  def index
    @users = User.search(params).paginate(:page => params[:page], :per_page => 5)
    @search = params || {}
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
    end
  end
end
