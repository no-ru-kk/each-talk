class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string     :name,          null: false
      t.text       :explain,       null: false
      t.integer    :dayotw_id,     null: false
      t.integer    :rtime_id,      null: false
      t.integer    :htime_id,      null: false
      t.integer    :mtime_id,      null: false
      t.integer    :price,         null: false
      t.references :user,          foreign_key: true
      t.timestamps
    end
  end
end
