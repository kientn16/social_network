class Point < ActiveRecord::Base
  belongs_to :user
  # params user_id: User Id; type: 1-Add Point, 2-Minus Point

  def self.update_point (user_id)
    user_id = user_id.to_i
    check = Point.find_by_user_id(user_id)
    if !check
      #insert new record and add point
      point = Point.new(:user_id => user_id, :point => 1)
      point.save
    else
      point_old = check.point
      point = point_old + 1
      check.update(:point => point)
    end
  end
end
