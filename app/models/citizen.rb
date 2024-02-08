class Citizen < ApplicationRecord
  belongs_to :state
  belongs_to :city

  validates :state_id, :city_id, :name, :cpf, :cns, :phone, :birthdate, presence: true
  validates :phone, format: { with: /\A\+55\d{2}\d{9}\z/ }
  validates_email_format_of :email, disposable: false
  validates_cpf_format_of :cpf

  before_validation do
    self.phone = phone.scan(/[+\d]/).join('')
  end
end
