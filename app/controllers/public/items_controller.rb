class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.order(created_at: :desc).page(params[:page]).per(8)
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_items = CartItem.new
  end
  
  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)  
  end
end
