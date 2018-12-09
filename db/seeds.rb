# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |i|
  User.create(email: "test_#{i}@yopmail.com", password: '123456789', username: "test@#{i}")
end
ids = User.pluck(:id)
loc_arr = ['londan', 'paris', 'india']
3.times do |i|
  Location.create!(address: loc_arr[i], user_id: ids[i])
end

SharedLocation.create!(user_id: User.first.id, location_id: User.first.locations.first.id, private: true,shared_with_id: User.last.id)
SharedLocation.create!(user_id: User.second.id, location_id: User.second.locations.first.id,private: false)
