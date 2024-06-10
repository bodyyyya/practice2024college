class AddPriceToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_column :cart_items, :price, :decimal
  end
end
