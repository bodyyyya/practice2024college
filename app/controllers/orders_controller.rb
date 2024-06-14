class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @cart = current_user.cart
    if @cart.cart_items.empty?
      redirect_to games_path, alert: "Your cart is empty. Add some games to proceed."
    end
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total_price = current_user.cart.total_price

    if @order.save
      # Associate cart items with the order
      current_user.cart.cart_items.update_all(order_id: @order.id)

      # Send the order confirmation email
      OrderMailer.order_confirmation(@order).deliver_now

      current_user.cart.cart_items.destroy_all # Clear the cart after order is placed
      redirect_to root_path, notice: "Your order has been placed successfully."
    else
      @cart = current_user.cart
      render :new, alert: "There was an error placing your order. Please try again."
    end
  end

  private

  def order_params
    params.require(:order).permit(:shipping_address, :payment_method)
  end
end
