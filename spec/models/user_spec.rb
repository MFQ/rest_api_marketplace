# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  auth_token             :string           default("")
#

require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }
  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should validate_presence_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should validate_uniqueness_of(:email) }

  it { should validate_uniqueness_of(:auth_token) }
  it { should respond_to(:auth_token) }

  describe "#generate_authentication_token!" do 
    it "generate a unique token" do
      Devise.stub(:friendly_token).and_return("auniquetoken123121312")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123121312"
    end

    it "generate another token when one already has been taken" do 
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123121312" )
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
    
  end

  describe "#products association" do

    before do
      @user.save
      3.times { FactoryGirl.create :product, user: @user, published: true }
    end

    it "destroys the associated products on self destruct" do
      products = @user.products
      @user.destroy
      products.each do |product|
        expect(Product.find(product)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  it { should have_many(:products) }
  
end
