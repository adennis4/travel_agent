class CreateFlightRecords < ActiveRecord::Migration
  def up
    create_table :flight_records do |t|
      t.string :confirmation, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :status, default: 'incomplete'
      t.string :boarding_number
      t.datetime :depart_at, null: false
      t.timestamps
    end
  end

  def down
    drop_table :flight_records
  end
end
