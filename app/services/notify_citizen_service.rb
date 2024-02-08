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
    case type
    when :created
      send_sms(sms_message_created)
    when :activated
      send_sms(send_sms_activated)
    when :inactivated
      send_sms(send_sms_inactivated)
    end
  end

  private

  attr_reader :citizen, :type, :sms_service

  def send_sms(message)
    sms_service.call(to: @citizen.phone, body: message)
  end

  def sms_message_created
    I18n.t("messages.sms_sender.welcome", name: @citizen.name)
  end

  def send_sms_activated
    I18n.t("messages.sms_sender.activated", name: @citizen.name)
  end

  def send_sms_inactivated
    I18n.t("messages.sms_sender.inactivated", name: @citizen.name)
  end
end
