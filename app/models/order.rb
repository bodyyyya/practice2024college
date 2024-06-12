class Order < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  validates :shipping_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
end
