require 'rails_helper'

RSpec.describe User, type: :model do
  it "must have a correctly formatted email address" do
    user = User.new(email: 'alice@alice.com')
    
    user.valid?

    expect(user.errors[:email].empty?).to be(true)
  end

  it "is invalid if email is incorrectly formatted" do
    user1 = User.new(email: 'alice@alice')
    user2 = User.new(email: 'alice.com')

    user1.valid?
    user2.valid?

    expect(user1.errors[:email][0]).to eq("is invalid")
    expect(user2.errors[:email][0]).to eq("is invalid")
  end

  it "is invalid if email is empty" do
    user = User.new

    user.valid?

    expect(user.errors[:email][0]).to eq("can't be blank")
  end

  it "should have unique email" do
    FactoryBot.create(:user)
    user = FactoryBot.build(:user)

    user.valid?

    expect(user.errors[:email][0]).to eq("has already been taken")
  end
end
