class Citizen < ApplicationRecord
  belongs_to :state
  belongs_to :city

  validates :state_id, :city_id, :name, :cns, :birthdate, presence: true
  validates :email, presence: true, email: true
  validates :phone, format: { with: /\A\+55\d{2}\d{9}\z/ }, presence: true
end
