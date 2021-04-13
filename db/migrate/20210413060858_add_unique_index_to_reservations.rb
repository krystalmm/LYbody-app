class AddUniqueIndexToReservations < ActiveRecord::Migration[5.2]
  def change
    add_index :reservations, [:start_time, :instructor_id], unique: true
  end
end
