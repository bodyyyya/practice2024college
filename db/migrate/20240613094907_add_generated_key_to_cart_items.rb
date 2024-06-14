class AddGeneratedKeyToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_column :cart_items, :generated_key, :string
  end
end
