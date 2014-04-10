require 'spec_helper'

describe User do

  before { @user = User.new(name: "Jimmy Boy", email: "jimmy@example.com") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when the email format is invalid" do
    it "should be invalid" do
      addresses = %w[jimmy@ex,com jimmy_at_ex.com jimmy@foo.]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email is valid" do
    it "should be valid" do
      addresses = %w[jimmy@ex.com THE-BOSS@us.ex.com THE_BOSS@us.ex.com cousin@ex.uk a+b@ex.com]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

end

