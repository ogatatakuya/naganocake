class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end
  
  def new
    @item = Item.new
    @genres = Genre.all
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      redirect_to new_admin_item_path
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path
    else
      redirect_to edit_admin_item_path(item.id)
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)  
  end
end
