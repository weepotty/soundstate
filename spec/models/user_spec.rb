require 'rails_helper'

RSpec.describe User, type: :model do
  it "must have a correctly formatted email address" do
    user = User.new(email: 'alice@alice.com')
    
    user.valid?

    expect(user.errors[:email].empty?).to be(true)
  end

  it "is an invalid user if email is incorrectly formatted" do
    user1 = User.new(email: 'alice@alice')
    user2 = User.new(email: 'alice.com')

    user1.valid?
    user2.valid?

    expect(user1.errors[:email].empty?).to be(false)
    expect(user2.errors[:email].empty?).to be(false)
  end
end
