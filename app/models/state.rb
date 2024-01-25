class State < ApplicationRecord
  has_many :cities

  validates :name, :acronym, presence: true, uniqueness: true
end
