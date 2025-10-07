# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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

Maintenance.find_or_create_by!(title: "オイル交換") do |maintenance|
  maintenance.maintenance_day = Date.today
  maintenance.maintenance = 'メンテナンス'
  maintenance.user = olivia
end

Maintenance.find_or_create_by!(title: "タイヤ交換") do |maintenance|
  maintenance.maintenance_day = Date.today
  maintenance.maintenance = '日常点検'
  maintenance.user = james
end

Maintenance.find_or_create_by!(title: "電球交換") do |maintenance|
  maintenance.maintenance_day = Date.today
  maintenance.maintenance = '法定点検'
  maintenance.user = lucas
end