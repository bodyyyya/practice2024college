class User < ApplicationRecord
  enum role: { user: 0, admin: 1 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy

  after_create :create_cart

  private

  def create_cart
    Cart.create(user: self)
  end  
end