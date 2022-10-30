class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def confirm
    @cart_items = current_customer.cart_items.all
    @total = 0
    @order = Order.new(order_params)
    @order.postage = 800
    #byebug

    if params[:order][:address_id] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_id] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    #elsif params[:order][:address_id] == "2"
      #@order.postal_code = params[:order][:postal_code]
     # @order.address = params[:order][:address]
      #@order.name = params[:order][:name]
    else
  
    end
    
    
  end
  
  def thanx
  end
  
  def create
     @order = Order.new(order_params)
     @order.customer_id = current_customer.id
     
     if @order.save
       cart_items = current_customer.cart_items.all
        cart_items.each do |cart_item|
         
         @orders = OrderDetail.new
         @orders.item_id = cart_item.item_id
         @orders.price = cart_item.item.price
         @orders.amount = cart_item.amount
         @orders.order_id = @order.id
         @orders.save
         
        end
       current_customer.cart_items.destroy_all
      redirect_to order_thanx_path
     else
      redirect_to new_customer_session_path
     end
  end
  
  def index
    @orders = current_customer.orders
   
  end
  
  def show
    @order = Order.find(params[:id])
    @total = 0
    @cart_items = current_customer.cart_items.all
    @order.postage = 800
  end
  
  private
  def order_params
    params.require(:order).permit(:address, :name, :postal_code, :payment, :postage, :billing_amount, :order_status)
  end
end
