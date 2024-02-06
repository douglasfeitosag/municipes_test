class Services::Citizens::Create < Services::Base
  def initialize(data)
    @data = data
  end

  def call
    Citizen.create!(@data)
  end

  private

  attr_reader :data
end