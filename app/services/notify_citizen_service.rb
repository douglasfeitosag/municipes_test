class NotifyCitizenService < BaseService
  def self.call(citizen, type)
    new(citizen, type).call
  end

  def initialize(citizen, type)
    @citizen = citizen
    @type = type
    @sms_service = SmsSenderService
  end

  def call
    email = @citizen.email

    case type
    when :created
      CitizenMailer.with(email: email, message: message_created).email.deliver_later

      send_sms(message_created)
    when :activated
      CitizenMailer.with(email: email, message: message_activated).email.deliver_later

      send_sms(message_activated)
    when :inactivated
      CitizenMailer.with(email: email, message: message_inactivated).email.deliver_later

      send_sms(message_inactivated)
    end
  end

  private

  attr_reader :citizen, :type, :sms_service

  def send_sms(message)
    sms_service.call(to: @citizen.phone, body: message)
  end

  def message_created
    I18n.t("messages.sms_sender.welcome", name: @citizen.name)
  end

  def message_activated
    I18n.t("messages.sms_sender.activated", name: @citizen.name)
  end

  def message_inactivated
    I18n.t("messages.sms_sender.inactivated", name: @citizen.name)
  end
end
