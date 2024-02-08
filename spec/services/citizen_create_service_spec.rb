require 'rails_helper'

RSpec.describe CitizenCreateService, type: :service do
  before do
    ActiveJob::Base.queue_adapter = :test
  end

  describe '#call' do
    context 'when citizen is valid' do
      it 'creates the citizen, schedules a job, and returns success' do
        citizen = build(:citizen)
        service = CitizenCreateService.new(citizen)

        result = service.call

        expect(result).to eq({ success: true })
        expect(Citizen.exists?(citizen.id)).to be true
        expect(NotifyCitizenJob).to have_been_enqueued.with(id: citizen.id, type: :created)
      end
    end

    context 'when citizen is invalid' do
      it 'does not create the citizen, does not schedule a job, and returns failure' do
        citizen = build(:citizen, phone: "")
        service = CitizenCreateService.new(citizen)

        result = service.call

        expect(result).to eq({ success: false })
        expect(Citizen.exists?(citizen.id)).to be false
        expect(NotifyCitizenJob).not_to have_been_enqueued
      end
    end
  end
end