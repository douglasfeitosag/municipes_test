class Citizen < ApplicationRecord
  has_one :address

  validates :name, :cpf, :cns, :phone, :birthdate, presence: true
  validates :phone, format: { with: /\A\+55\d{2}\d{9}\z/ }
  validates_email_format_of :email, disposable: true
  validates_cpf_format_of :cpf

  accepts_nested_attributes_for :address

  scope :search, -> q do
    search = "%#{q}%"

    joins(:address).where("
      name ilike ? or phone ilike ? or email ilike ? or cpf ilike ? or cns ilike ?
      or addresses.zipcode ilike ? or addresses.street ilike ? or addresses.neighbourhood ilike ?
    ", search, search, search, search, search, search, search, search)
  end

  before_validation do
    self.phone = phone&.scan(/[+\d]/)&.join("")
  end
end
