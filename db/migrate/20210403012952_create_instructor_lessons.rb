class CreateInstructorLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :instructor_lessons do |t|
      t.references :instructor, foreign_key: true, null: false
      t.references :lesson, foreign_key: true, null: false

      t.timestamps
    end
  end
end
