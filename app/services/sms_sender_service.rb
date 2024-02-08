class SmsSenderService < BaseService
  def self.call(to:, body:)
    new(to: to, body: body).call
  end

  def initialize(to:, body:, sender: SmsSender::Twilio)
    @sender = sender.new(to: to, body: body)
  end

  def call
    @sender.call
  end
end