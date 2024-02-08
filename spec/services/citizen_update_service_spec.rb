require 'rails_helper'

RSpec.describe CitizenUpdateService, type: :service do
  describe '.call' do
    it 'updates the citizen and returns success' do
      citizen = create(:citizen)
      params = { name: 'New Name' }

      result = CitizenUpdateService.call(citizen, params)

      expect(result).to eq({ success: true })
      expect(citizen.reload.name).to eq('New Name')
    end

    it 'does not update the citizen and returns failure if invalid' do
      citizen = create(:citizen)
      params = { name: '' }

      result = CitizenUpdateService.call(citizen, params)

      expect(result).to eq({ success: false })
      expect(citizen.reload.name).not_to eq('')
    end

    it 'notifies if the status changed' do
      citizen = create(:citizen, active: false)
      params = { active: true }
      allow(NotifyCitizenJob).to receive(:perform_later)

      CitizenUpdateService.call(citizen, params)

      expect(NotifyCitizenJob).to have_received(:perform_later).with(id: citizen.id, type: :activated)
    end

    it 'does not notify if the status did not change' do
      citizen = create(:citizen, active: true)
      params = { name: 'New Name' }
      allow(NotifyCitizenJob).to receive(:perform_later)

      CitizenUpdateService.call(citizen, params)

      expect(NotifyCitizenJob).not_to have_received(:perform_later)
    end
  end
end