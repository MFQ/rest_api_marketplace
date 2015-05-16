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

  describe ".filter_by_title" do

    before(:each) do
      @product1 = FactoryGirl.create :product, title: "A plasma TV"
      @product2 = FactoryGirl.create :product, title: "Fastest Laptop"
      @product3 = FactoryGirl.create :product, title: "CD player"
      @product4 = FactoryGirl.create :product, title: "LCD TV"
    end

    context "when TV title pattern is sent" do 
      it "retrun the 2 products matching" do 
        expect(Product.filter_by_title("TV").sort.length).to eq(2)
      end

      it "return the products match" do 
        expect(Product.filter_by_title("TV").sort).to match_array([@product1, @product4])
      end
    end

  end

end
