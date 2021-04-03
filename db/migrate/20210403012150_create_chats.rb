class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.references :room, foreign_key: true, null: false
      t.boolean :is_user, null: false, default: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
