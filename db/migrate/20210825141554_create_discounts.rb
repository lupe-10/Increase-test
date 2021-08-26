class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.string :id_discount
      t.integer :amount
      t.references :payments, foreign_key: true
      t.integer :type
      t.timestamps
    end
  end
end
