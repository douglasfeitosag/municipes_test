require "rails_helper"

RSpec.describe City, type: :model do
  describe "validations" do
    subject { described_class.new(name: "Goiás", state: create(:state)) }

    it { should validate_presence_of(:state_id) }
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:name).scoped_to(:state_id) }
  end

  describe "associations" do
    it { should belong_to(:state) }
  end

  describe "behavior" do
    it "should not allow creation with duplicate name with state scope" do
      city = create(:city)
      duplicate_city = build(:city, state: city.state)

      expect(duplicate_city).not_to be_valid
      expect(duplicate_city.errors.full_messages).to eq(["Nome já está em uso"])
    end
  end
end