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

require 'rails_helper'

RSpec.describe Product, type: :model do
	let(:product) { FactoryGirl.build(:product) }
	subject {product}

 it { should respond_to(:title) }
 it { should respond_to(:price) }
 it { should respond_to(:published) }
 it { should respond_to(:user_id) }
end
