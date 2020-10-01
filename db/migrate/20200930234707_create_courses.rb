class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :kind, null: false
      t.string :level, null: false
      t.string :shift, null: false
      t.references :university, foreign_key: true
      t.references :campus, foreign_key: true

      t.timestamps
    end
  end
end
