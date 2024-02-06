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

def create_user
  User.create!(email: "admin@admin.com", password: "123456789") if User.none?
end

def create_citizens
  if Citizen.none?
    city = City.find_by_name("Goiânia")
    state = city.state

    Citizen.create!(
      state: state,
      city: city,
      name: "Douglas",
      cpf: Faker::CPF.numeric,
      cns: Faker::Number.number,
      email: Faker::Internet.email,
      birthdate: Faker::Date.birthday,
      phone: "+5511999999999"
    )
  end
end

ActiveRecord::Base.transaction do
  populate_states_and_cities
  create_user
  create_citizens
end
