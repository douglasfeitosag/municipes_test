require "rails_helper"

RSpec.describe Citizen, type: :model do
  describe "validations" do
    context "validates" do
      subject { create(:citizen, email: "douglas@gmail.com") }

      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:cns) }
      it { is_expected.to validate_presence_of(:birthdate) }
      it { is_expected.to validate_presence_of(:email).with_message("não parece ser um e-mail válido") }
      it { is_expected.to validate_presence_of(:phone) }
      it { is_expected.to allow_value("test@outlook.com").for(:email) }
      it { is_expected.not_to allow_value("test@").for(:email) }
      it { is_expected.to allow_value("+5562999999999").for(:phone) }
      it { is_expected.not_to allow_value("+199999999999").for(:phone) }
    end

    context "phone validation" do
      it "accepts valid phone numbers" do
        valid_phone_numbers = %w[+5562983118756 +5561999999999 +5511940028922]

        valid_phone_numbers.each do |phone_number|
          citizen = build(:citizen, phone: phone_number)
          expect(citizen).to be_valid
        end
      end

      it "rejects invalid phone numbers" do
        invalid_phone_numbers = %w[+5462983118756 62983118756 1140028922 556298311875 abc123456789]

        invalid_phone_numbers.each do |phone_number|
          citizen = build(:citizen, phone: phone_number)
          expect(citizen).not_to be_valid
        end
      end
    end
  end
end