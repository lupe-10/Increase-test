class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :id_transaction
      t.integer :amount
      t.integer :type
      t.references :payment, foreign_key: true
      t.timestamps
    end
  end
end
