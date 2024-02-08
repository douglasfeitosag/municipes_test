require "twilio-ruby"

class SmsSender::Twilio < BaseService
  def initialize(to:, body:)
    @to = to
    @body = body
  end

  def call
    client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])

    client.messages.create(
      from: ENV["TWILIO_NUMBER"],
      to: to,
      body: body
    )
  end

  private

  attr_reader :to, :body
end
