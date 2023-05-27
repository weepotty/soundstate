require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'email' do
    it "must be correctly formatted" do
      user = User.new(email: 'alice@alice.com')
      
      user.valid?
  
      expect(user.errors[:email].empty?).to be(true)
    end
  
    it "is invalid if incorrectly formatted" do
      user1 = User.new(email: 'alice@alice')
      user2 = User.new(email: 'alice.com')
  
      user1.valid?
      user2.valid?
  
      expect(user1.errors[:email][0]).to eq("is invalid")
      expect(user2.errors[:email][0]).to eq("is invalid")
    end
  
    it "can't be blank" do
      user = User.new
  
      user.valid?
  
      expect(user.errors[:email][0]).to eq("can't be blank")
    end
  
    it "should be unique" do
      FactoryBot.create(:user)
      user = FactoryBot.build(:user)
  
      user.valid?
  
      expect(user.errors[:email][0]).to eq("has already been taken")
    end
  end
end
