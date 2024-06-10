class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart || current_user.create_cart
    @cart_item = @cart.cart_items.find_by(game_id: params[:game_id])

    if @cart_item
      @cart_item.quantity += 1
    else
      @cart_item = @cart.cart_items.build(game_id: params[:game_id], quantity: 1, price: Game.find(params[:game_id]).price)
    end

    if @cart_item.save
      redirect_to cart_path, notice: 'Item added to cart.'
    else
      redirect_to games_path, alert: 'Unable to add item to cart.'
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: 'Cart item updated.'
    else
      redirect_to cart_path, alert: 'Unable to update cart item.'
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Item removed from cart.'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
