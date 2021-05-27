class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string     :name,          null: false
      t.integer    :time_id,       null: false
      t.integer    :price,         null: false
      t.timestamps
    end
  end
end
