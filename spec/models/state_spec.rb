require "rails_helper"

RSpec.describe State, type: :model do
  describe "validations" do
    subject { described_class.new(name: "Goiás", acronym: "GO") }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:acronym) }
    it { should validate_uniqueness_of(:acronym) }
  end

  describe "associations" do
    it { should have_many(:cities) }
  end

  describe "behavior" do
    it "should not allow creation with duplicate name and acronym" do
      create(:state)
      duplicate_state = build(:state)
      expect(duplicate_state).not_to be_valid
    end
  end
end