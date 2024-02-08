require 'rails_helper'

RSpec.describe SmsSenderService, type: :service do
  describe '.call' do
    it 'delegates to an instance of the service' do
      to = '+551234567890'
      body = 'Test message'
      sender = double(:sender, call: true)
      allow(SmsSender::Twilio).to receive(:new).and_return(sender)

      result = SmsSenderService.call(to: to, body: body)

      expect(SmsSender::Twilio).to have_received(:new).with(to: to, body: body)
      expect(sender).to have_received(:call)
      expect(result).to eq(true)
    end
  end
end
