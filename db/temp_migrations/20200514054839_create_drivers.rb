class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :email
      t.integer :phone_number
      t.string :license_number
      t.string :car_number
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
    add_index :drivers, [:latitude, :longitude]
  end
end
