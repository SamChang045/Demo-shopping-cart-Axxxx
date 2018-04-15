namespace :dev do

  task fake: :environment do
    Product.destroy_all

    500.times do |i|
      Product.create!(name: FFaker::Product::product_name,
        price: 100+rand(1000),
        description: FFaker::Lorem::sentence(30),
        category: Category.all.sample
      )
    end

    puts "have created fake products"
    puts "now you have #{Product.count} products data"
  end

end