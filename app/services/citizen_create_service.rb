class CitizenCreateService < BaseService
  attr_reader :citizen

  def initialize(citizen)
    @citizen = citizen
  end

  def call
    if @citizen.save
      NotifyCitizenJob.perform_later(id: @citizen.id, type: :created)

      { success: true }
    else
      { success: false }
    end
  end
end