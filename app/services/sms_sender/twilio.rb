require 'twilio-ruby'

class SmsSender::Twilio < BaseService
  def initialize(to:, body:)
    @to = to
    @body = body
  end

  def call
    twilio_sid = Rails.application.credentials.twilio[:account_sid]
    twilio_token = Rails.application.credentials.twilio[:auth_token]
    twilio_number = Rails.application.credentials.twilio[:number]

    client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    client.messages.create(
      from: twilio_number,
      to: to,
      body: body
    )
  end

  private

  attr_reader :to, :body
end