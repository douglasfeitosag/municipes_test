FactoryBot.define do
  factory :address do
    citizen
    state
    city

    zipcode { "75000000" }
    street { "Rua 1" }
    complement { "Apto" }
    neighbourhood { "Centro" }
    ibge_code { "123" }
  end
end
