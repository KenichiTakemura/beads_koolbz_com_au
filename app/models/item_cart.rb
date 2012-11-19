class ItemCart < ActiveRecord::Base
  
  belongs_to :item
  belongs_to :item_checkout
  
  def to_s 
    "item_checkout: #{item_checkout} item: #{item}"
  end
  
end
