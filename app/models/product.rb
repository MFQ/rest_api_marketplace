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

class Product < ActiveRecord::Base
	validates :title, :published, :price, :user_id, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0 }
	belongs_to :user

	scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}") }
	scope :above_or_equal_to_price, lambda { |price| where("price>=?", price) }
end
