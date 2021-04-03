class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.references :user, foreign_key: true, null: false
      t.references :instructor, foreign_key: true, null: false

      t.timestamps
    end
  end
end
