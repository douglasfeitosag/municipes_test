require 'rails_helper'

RSpec.describe Citizen, type: :model do
  let(:city) { create(:city) }
  let(:state) { city.state }

  describe "associations" do
    it { should belong_to(:state) }
    it { should belong_to(:city) }
  end

  describe "validations" do
    context "validates" do
      subject { create(:citizen, state: state, city: city) }

      it { should validate_presence_of(:state_id) }
      it { should validate_presence_of(:city_id) }
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:cns) }
      it { should validate_presence_of(:birthdate) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:phone) }
      it { should allow_value("test@test.com").for(:email) }
      it { should_not allow_value("test@").for(:email) }
      it { should allow_value("+5562999999999").for(:phone) }
      it { should_not allow_value("+199999999999").for(:phone) }
    end

    context "phone validation" do
      it "accepts valid phone numbers" do
        valid_phone_numbers = %w[+5562983118756 +5561999999999 +5511940028922]

        valid_phone_numbers.each do |phone_number|
          citizen = build(:citizen, state: state, city: city, phone: phone_number)
          expect(citizen).to be_valid
        end
      end

      it "rejects invalid phone numbers" do
        invalid_phone_numbers = %w[+5462983118756 62983118756 1140028922 556298311875 abc123456789 +5500999999999]

        invalid_phone_numbers.each do |phone_number|
          citizen = build(:citizen, phone: phone_number)
          expect(citizen).not_to be_valid
        end
      end
    end
  end
end