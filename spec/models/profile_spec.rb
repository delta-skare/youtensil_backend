require 'rails_helper'

RSpec.describe Profile, type: :model do
  before(:each) do
    @user1 = User.create(email: 'foodie@example.com', password: 'testy123', password_confirmation: 'testy123')
  end
  subject { described_class.new(user_id: @user1.id, bio: "I'm a profile", food_types: 'good food, bad food', username: 'bob') }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a bio" do
    subject.bio = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a list of food types" do
    subject.food_types = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a user id" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end
end
