# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Category

Category.destroy_all

category_list = [
  { name: "Books & Audible" },
  { name: "Movies, Music & Games" },
  { name: "Electronics, Computers & Office" },
  { name: "Home, Garden, Pets & Tools" },
  { name: "Food & Grocery" },
  { name: "Beauty & Health" },
  { name: "Toys, Kids & Baby" }
]

category_list.each do |category|
  Category.create( name: category[:name] )
end
puts "Category created!"

# Default admin

User.create(email: "root@example.com", password: "000000", role: "admin")
puts "Default admin created!"