class City < ApplicationRecord
  belongs_to :state

  validates :state_id, :name, presence: true
  validates_uniqueness_of :name, scope: :state_id
end
