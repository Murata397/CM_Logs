# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "seedの実行を開始"

olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
end

olivia_profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename: "sample-user1.jpg")
olivia.profile_image.attach(olivia_profile_image)

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
end

james_profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename: "sample-user2.jpg")
james.profile_image.attach(james_profile_image)

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
end

lucas_profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename: "sample-user3.jpg")
lucas.profile_image.attach(lucas_profile_image)

voxy_car = Car.find_or_create_by!(car_name: 'Voxy') do |c|
  c.user_id = 1
  car_image_blob = ActiveStorage::Blob.create_after_upload!(
    io: File.open("#{Rails.root}/db/fixtures/Voxy.jpg"),
    filename: "Voxy.jpg"
  )
  c.car_image.attach(car_image_blob)
  c.manufacturer_name = 'Toyota'
  c.car_model = '95'
  c.odometer = '50000 km'
  c.purpose = '通勤・通学'
end

noah_car = Car.find_or_create_by!(car_name: 'Noah') do |c|
  c.user_id = 2
  car_image_blob = ActiveStorage::Blob.create_after_upload!(
    io: File.open("#{Rails.root}/db/fixtures/Noah.jpg"),
    filename: "Noah.jpg"
  )
  c.car_image.attach(car_image_blob)
  c.manufacturer_name = 'Toyota'
  c.car_model = '95'
  c.car_name = 'Noah'
  c.odometer = '70000 km'
  c.purpose = '日常・レジャー'
end

landy_car = Car.find_or_create_by!(car_name: 'Landy') do |c|
  c.user_id = 3
  car_image_blob = ActiveStorage::Blob.create_after_upload!(
    io: File.open("#{Rails.root}/db/fixtures/Landy.jpg"),
    filename: "Landy.jpg"
  )
  c.car_image.attach(car_image_blob)
  c.manufacturer_name = 'Suzuki'
  c.car_model = '95'
  c.car_name = 'Landy'
  c.odometer = '1000 km'
  c.purpose = 'コレクション'
end

voxy_car = Car.find_by(car_name: 'Voxy')
Maintenance.find_or_create_by!(title: "タイヤ交換") do |maintenance|
  maintenance.car = voxy_car
  maintenance.maintenance_day = Date.today
  maintenance.maintenance = '日常点検'
  maintenance.work_difficulty = '普通'
  maintenance.is_active = :published
  maintenance.user = User.find_by(name: 'James')
end

noah_car = Car.find_by(car_name: 'Noah')
Maintenance.find_or_create_by!(title: "電球交換") do |maintenance|
  maintenance.car = noah_car
  maintenance.maintenance_day = Date.today
  maintenance.maintenance = '法定点検'
  maintenance.work_difficulty = '普通'
  maintenance.is_active = :published
  maintenance.user = User.find_by(name: 'Lucas')
end

landy_car = Car.find_by(car_name: 'Landy')
Maintenance.find_or_create_by!(title: "オイル交換") do |maintenance|
  maintenance.car = landy_car
  maintenance.maintenance_day = Date.today
  maintenance.maintenance = 'メンテナンス'
  maintenance.work_difficulty = '普通'
  maintenance.is_active = :published
  maintenance.user = User.find_by(name: 'Olivia')
end

puts "seedの実行が完了しました。"