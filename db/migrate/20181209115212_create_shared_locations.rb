class CreateSharedLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :shared_locations do |t|
      t.references :user, foreign_key: true
      t.references :location, foreign_key: true
      t.boolean :private, default: false
      t.integer :shared_with_id
      t.timestamps
    end
  end
end
