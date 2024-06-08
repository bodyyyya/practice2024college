class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :game

  def total_price
    game.price * quantity
  end
end