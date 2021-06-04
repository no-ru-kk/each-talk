class CreateTroomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :troom_users do |t|
      t.references :user,       foreign_key: true
      t.references :troom,      foreign_key: true
      t.timestamps
    end
  end
end
