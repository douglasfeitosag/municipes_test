class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :citizen, null: false, index: true
      t.references :state, null: false, index: true
      t.references :city, null: false, index: true
      t.string :zipcode, null: false
      t.string :street, null: false
      t.string :complement
      t.string :neighbourhood, null: false
      t.string :ibge_code

      t.timestamps
    end

    add_foreign_key :addresses, :citizens
    add_foreign_key :addresses, :states
    add_foreign_key :addresses, :cities
  end
end
