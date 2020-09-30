class CreateUniversities < ActiveRecord::Migration[5.2]
  def change
    create_table :universities do |t|
      t.string :name, null: false
      t.decimal :score, precision: 5, scale: 2, default: 0.0
      t.string :logo_url

      t.timestamps
    end
  end
end
