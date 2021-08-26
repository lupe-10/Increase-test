class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :id_payment
      t.string :tipe_of_currency
      t.integer :total_amount
      t.integer :total_discount
      t.integer :total_with_discount
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
