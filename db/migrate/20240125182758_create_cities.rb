class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.references :state, null: false, index: true
      t.string :name, null: false

      t.timestamps
    end

    add_index :cities, [:state_id, :name], unique: true
  end
end
