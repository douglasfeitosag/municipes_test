def populate_states_and_cities
  if State.none?

    path = Rails.root.join('db', 'assets', 'states_cities.json')
    data = JSON.parse(File.open(path).read)

    data["estados"].each do |state_json|
      state = State.create!(name: state_json["nome"], acronym: state_json["sigla"])

      state_json["cidades"].each do |city|
        state.cities.create!(name: city)
      end
    end
  end
end

ActiveRecord::Base.transaction do
  populate_states_and_cities
end
