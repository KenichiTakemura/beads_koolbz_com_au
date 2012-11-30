class ItemCheckout < Cachable
  # many-to-many
  has_many :item_cart
  has_many :item, :through => :item_cart
  
  belongs_to :ordered_by, :polymorphic => true
  belongs_to :order
  
  def get_item
    item
  end
  
  def add_order(item, p_count=nil)
    if !self.item.include?(item)
      self.item << item
    else
      e_item = self.item_cart.find_by_item_id(item)
      count = p_count.present? ? p_count.to_i : e_item.order_count + 1
      e_item.update_attribute(:order_count, count)
    end
  end
  
  def remove_order(item)
    self.item.destroy(item)
  end
  
  def clear_order
    self.item.destroy_all
  end
  
  def has_item?
    self.item.present?
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
  
  def ordered(o)
    update_attribute(:order, o)
  end
  
  def item_count(item)
    item_cart.find_by_item_id(item).order_count
  end
  
end
