class AddPhotoToCitizens < ActiveRecord::Migration[7.1]
  def change
    add_column :citizens, :photo, :string
  end
end
