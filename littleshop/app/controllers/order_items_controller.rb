class OrderItemsController < ApplicationController
  # TASK-2
  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @order.save
    reserve_from_stock
    session[:order_id] = @order.id
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    update_stock
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
    @order.save
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    return_to_stock
    @order_item.destroy
    @order_items = @order.order_items
    @order.save
  end

private
  # TODO move to appropriate location!
  def reserve_from_stock
    @product = Product.find(params[:order_item][:product_id])
    @product.amount_in_stock = @product.amount_in_stock - @order_item.quantity
    @product.save
  end

  def update_stock    
    @product = Product.find(params[:order_item][:product_id])
    if @order_item.quantity < params[:order_item][:quantity].to_i
      @product.amount_in_stock = @product.amount_in_stock - (params[:order_item][:quantity].to_i - @order_item.quantity)
    else
      @product.amount_in_stock = @product.amount_in_stock + (@order_item.quantity - params[:order_item][:quantity].to_i)
    end
    
    @product.save
  end

  def return_to_stock
    @order_item.product.amount_in_stock = @order_item.product.amount_in_stock + @order_item.quantity
    @order_item.product.save
  end
  # TODO until here and do them better :D


  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
