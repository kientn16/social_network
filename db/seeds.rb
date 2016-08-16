# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
FriendStatus.delete_all

# User
csv_user_text = File.read(Rails.root.join('lib', 'seeds', 'seed-users.csv'))
csv_user = CSV.parse(csv_user_text, :headers => true, :encoding => 'ISO-8859-1')
csv_user.each do |row|
  t = User.new
  t.name = row['name']
  t.email = row['email']
  t.password = row['password']
  t.address = row['address']
  t.phone = row['phone']
  t.image = row['image']
  t.save
end


# Friend Status
csv_friend_status_text = File.read(Rails.root.join('lib', 'seeds', 'seed-friend-status.csv'))
csv_friend_status = CSV.parse(csv_friend_status_text, :headers => true, :encoding => 'ISO-8859-1')
csv_friend_status.each do |row|
  t = FriendStatus.new
  t.name = row['name']
  t.save
end

puts "There are now #{FriendStatus.count} rows in the transactions table"