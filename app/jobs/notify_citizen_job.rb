class NotifyCitizenJob < ApplicationJob
  queue_as :default

  def perform(id:, type:)
    citizen = Citizen.find(id)

    NotifyCitizenService.call(citizen, type)
  end
end