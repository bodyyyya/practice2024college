class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :game
  belongs_to :order, optional: true

  before_create :set_price

  def generated_keys
    JSON.parse(self[:generated_keys] || '[]')
  end

  def generated_keys=(keys)
    self[:generated_keys] = keys.to_json
  end

  def total_price
    (price || game.price) * quantity
  end

  private

  def set_price
    self.price ||= game.price
  end
end
