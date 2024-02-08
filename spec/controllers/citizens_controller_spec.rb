require "rails_helper"

describe CitizensController, type: :controller do
  render_views

  include Devise::Test::ControllerHelpers

  let(:user) { create(:user)  }

  before do
    sign_in user
  end

  describe "GET #data" do
    it "returns the search results" do
      city = create(:city)
      citizen1 = create(:citizen, name: "John Doe")
      create(:address, citizen: citizen1, city: city, state: city.state)
      citizen2 = create(:citizen, name: "Jane Doe")
      create(:address, citizen: citizen2, city: city, state: city.state)

      get :data, params: { q: "Doe" }

      expect(response.body.include?(citizen1.name)).to be_truthy
      expect(response.body.include?(citizen2.name)).to be_truthy
    end
  end

  describe "GET #cities" do
    it "returns the cities for a given state" do
      state = create(:state)
      city1 = create(:city, state: state)
      city2 = create(:city, name: "Sao Paulo", state: state)

      get :cities, params: { state_id: state.id }

      expect(response.body.include?(city1.name)).to be_truthy
      expect(response.body.include?(city2.name)).to be_truthy
    end
  end
end