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

  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  it { should validate_presence_of :published }

  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :user_id }
  it { should belong_to :user }

end
