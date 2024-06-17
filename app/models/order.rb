class Order < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def generate_keys_for_cart_items
    cart_items.each do |item|
      item.generated_keys = Array.new(item.quantity) { SecureRandom.hex(8) }
      item.save
    end
  end
end
