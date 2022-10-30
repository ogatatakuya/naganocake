class Item < ApplicationRecord
  has_many :cart_item
  
  belongs_to :genre
   
  has_one_attached :image
  
  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  
  has_many :order_details
  
  def with_tax_price
    (price * 1.1).floor
  end
end
