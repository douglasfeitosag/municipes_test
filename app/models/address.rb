class Address < ApplicationRecord
  belongs_to :citizen
  belongs_to :state
  belongs_to :city

  validates :zipcode, :street, :neighbourhood, presence: true
  validates_associated :state, :city
end
