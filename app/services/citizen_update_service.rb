class CitizenUpdateService < ::BaseService
  def initialize(citizen, citizen_params)
    @citizen = citizen
    @citizen_params = citizen_params
  end

  def call
    status_was = citizen.active?

    if citizen.update(citizen_params)
      notify_if_status_changed(status_was)

      { success: true }
    else
      { success: false }
    end
  end

  private

  attr_reader :citizen, :citizen_params

  def notify_if_status_changed(status_was)
    if citizen.active? != status_was
      NotifyCitizenJob.perform_later(id: citizen.id, type: citizen.active? ? :activated : :inactivated)
    end
  end
end
