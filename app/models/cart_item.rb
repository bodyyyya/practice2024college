class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :game

  before_create :set_price

  def total_price
    (price || game.price) * quantity
  end

  private

  def set_price
    self.price ||= game.price
  end
end
