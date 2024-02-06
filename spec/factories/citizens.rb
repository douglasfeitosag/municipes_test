FactoryBot.define do
  factory :citizen do
    Faker::Config.locale = 'pt-BR'

    state
    city
    name { "Douglas" }
    cpf { Faker::CPF.numeric }
    cns { Faker::Number.number }
    email { Faker::Internet.email }
    birthdate { Faker::Date.birthday }
    phone { "+5511999999999" }
    active { true }
  end
end
