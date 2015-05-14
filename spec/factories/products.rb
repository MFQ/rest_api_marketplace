# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  title      :string           default("")
#  price      :decimal(, )      default("0.0")
#  published  :boolean          default("false")
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :product do
    title { Faker::Product.product_name }
		price { rand(1..10) * 100 }
		published true
		user
  end

end
