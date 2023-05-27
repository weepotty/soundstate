require 'rails_helper'

RSpec.describe User, type: :model do
  it "must have a correctly formatted email address" do
    user = User.new(email: 'alice@alice.com')
    
    user.valid?

    expect(user.errors[:email].empty?).to be(true)
  end
end
