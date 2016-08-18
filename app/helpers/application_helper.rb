module ApplicationHelper
  def get_point (user_id)
    @data = Point.find_by_user_id(user_id)
    if @data
      return @data.point
    else
      return 0
    end
  end

end
