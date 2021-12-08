# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

types = ['Tops', 'Bottoms', 'Coats', 'Shoes', 'Dresses', 'Bags', 'Accessories']
status_all = ['accept', 'reject', 'pending']
50.times do
  user = User.create!(username: Faker::Name.name, wechat_id: Faker::Alphanumeric.alphanumeric(number: 10), email: Faker::Internet.email, password: Faker::Internet.password)
  # p user
  items = []
  10.times do
    items << Item.create!(user_id: user.id, item_type: types.sample, remark: Faker::Lorem.paragraph)
  end

  items.sample(3).each do |item|
    item.update(is_giveaway: true)
    Giveaway.create(user_id: user.id, item: item, status: status_all.sample)
  end
end
