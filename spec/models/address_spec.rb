require "rails_helper"

RSpec.describe Address, type: :model do
  let(:citizen) { create(:citizen) }
  let(:city) { create(:city) }
  let(:state) { city.state }

  describe "associations" do
    it { is_expected.to belong_to(:citizen) }
    it { is_expected.to belong_to(:state) }
    it { is_expected.to belong_to(:city) }
  end

  describe "validations" do
    context "validates" do
      subject { create(:address, citizen: citizen, state: state, city: city) }

      it { is_expected.to validate_presence_of(:zipcode) }
      it { is_expected.to validate_presence_of(:street) }
      it { is_expected.to validate_presence_of(:neighbourhood) }
    end
  end

  context "when zipcode, street, or neighbourhood is missing" do
    it "should be invalid" do
      address = build(:address, zipcode: nil, street: nil, neighbourhood: nil)
      expect(address).not_to be_valid
    end
  end

  context "when state or city is invalid" do
    it "should be invalid" do
      address = build(:address, state: nil, city: nil)
      expect(address).not_to be_valid
    end
  end
end
