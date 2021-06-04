class CreateTrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :trooms do |t|
      t.references :room,      foreign_key: true
      t.timestamps
    end
  end
end
