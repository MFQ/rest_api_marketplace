# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  total      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ActiveRecord::Base
  belongs_to :user

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  
end
