class ItemCheckout < Cachable
  # many-to-many
  has_many :item_cart
  has_many :item, :through => :item_cart
  
  belongs_to :ordered_by, :polymorphic => true
  
  def add_order(item)
    if !self.item.include?(item)
      self.item << item
    else
      e_item = self.item_cart.find_by_item_id(item)
      count = e_item.order_count
      e_item.update_attribute(:order_count, count + 1)
    end
  end
  
  def remove_order(item)
    self.item.destroy(item)
  end
  
  def total_price
    price = 0
    item.each do |i|
      count = item_count(i)
      price += (i.price_ex_gst * count)
    end
    price
  end
  
  def by(flyer)
    update_attribute(:ordered_by, flyer)
  end
  
  def item_count(item)
    item_cart.find_by_item_id(item).order_count
  end
  
end
