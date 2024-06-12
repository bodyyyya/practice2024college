class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.text :shipping_address
      t.string :payment_method
      t.decimal :total_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
