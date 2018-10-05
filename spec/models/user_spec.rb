require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(password: "some_password", email: "john@doe.com", password_confirmation: "some_password") }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a proper password confirmation" do
      subject.password_confirmation = "some_other_password"
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
    it "has one profile" do
      assc = described_class.reflect_on_association(:profile)
      expect(assc.macro).to eq :has_one
    end

    it "has many tips" do
      assc = described_class.reflect_on_association(:tips)
      expect(assc.macro).to eq :has_many
    end
  end

end
