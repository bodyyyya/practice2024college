class User < ApplicationRecord
  enum role: { user: 0, admin: 1 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy

  validate :password_complexity

  after_create :create_cart

  private

  def password_complexity
    if password.present? && !password.match(/^(?=.*[A-Z])(?=.*[0-9]).{10,}$/)
      errors.add :password, "must include at least one uppercase letter and one digit"
    end
  end

  def create_cart
    Cart.create(user: self)
  end  
end