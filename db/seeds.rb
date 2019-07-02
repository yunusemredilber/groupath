# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# --------- Test Values ---------- #

10.times do |i|
  user = User.create(username: "user#{i}", email: "user#{i}@something.com", first_name: "Yoyoyo#{i}", last_name: "Tester#{i}", password: "aaaaaa")
  # group = Group.create(groupname: "group#{i}", title: "Group#{i}", description: "This is a test group camed from seed.", admin_id: user.id)
end