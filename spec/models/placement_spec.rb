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

require 'rails_helper'

RSpec.describe Placement, type: :model do
	it { should validate_presence_of :order_id }
	it { should validate_presence_of :product_id }

	it { should belong_to :order }
	it { should belong_to :product }
end
