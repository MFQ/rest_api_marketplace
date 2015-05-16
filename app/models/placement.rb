# == Schema Information
#
# Table name: placements
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Placement < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates  :order_id, :product_id, presence: true
end
