class Order < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def generate_keys_for_cart_items
    cart_items.each do |item|
      item.generated_key = SecureRandom.hex(8) # 16 символів
    end
  end
end
