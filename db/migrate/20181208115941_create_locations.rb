class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.references :user, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
