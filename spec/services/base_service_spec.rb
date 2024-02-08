require 'rails_helper'

RSpec.describe BaseService, type: :service do
  class Service < BaseService
    def self.call
    end

    def call
    end
  end

  it "should raise an error when call base service without implementation" do
    expect { BaseService.new.call }.to raise_error(NotImplementedError)
    expect { BaseService.call }.to raise_error(NotImplementedError)
  end

  it "should not raise an error when creating a new instance" do
    expect { Service.new.call }.not_to raise_error
    expect { Service.call }.not_to raise_error
  end
end