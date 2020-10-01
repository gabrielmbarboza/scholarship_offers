class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.decimal :full_price, null: false
      t.decimal :price_with_discount
      t.decimal :discount_percentage
      t.date :start_date
      t.string :enrollment_semester
      t.boolean :enabled
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
