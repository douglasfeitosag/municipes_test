describe NotifyCitizenService, type: :service do
  describe ".call" do
    context "when type is :created" do
      it "sends an SMS with the creation message" do
        citizen = build(:citizen)
        type = :created
        allow(SmsSenderService).to receive(:call)

        NotifyCitizenService.call(citizen, type)

        expect(SmsSenderService).to have_received(:call).with(
          to: citizen.phone,
          body: I18n.t("messages.sms_sender.welcome", name: citizen.name)
        )
      end
    end

    context "when type is :activated" do
      it "sends an SMS with the activation message" do
        citizen = build(:citizen)
        type = :activated
        allow(SmsSenderService).to receive(:call)

        NotifyCitizenService.call(citizen, type)

        expect(SmsSenderService).to have_received(:call).with(
          to: citizen.phone,
          body: I18n.t("messages.sms_sender.activated", name: citizen.name)
        )
      end
    end

    context "when type is :inactivated" do
      it "sends an SMS with the inactivation message" do
        citizen = build(:citizen)
        type = :inactivated
        allow(SmsSenderService).to receive(:call)

        NotifyCitizenService.call(citizen, type)

        expect(SmsSenderService).to have_received(:call).with(
          to: citizen.phone,
          body: I18n.t("messages.sms_sender.inactivated", name: citizen.name)
        )
      end
    end
  end
end