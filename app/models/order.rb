class Order < Cachable
  has_many :item_history, :dependent => :destroy
  has_one :flyer, :as => :ordered_by
  
  def by(flyer)
    update_attribute(:ordered_by, flyer)
  end
  
  def add_item(item)
    logger.debug("adding an item #{item}")
    item_history = ItemHistory.new(:category => item.category,
    :status => Status::STATUS[:await_order],
    :barcode => item.barcode,
    :price_ex_gst => item.price_ex_gst)
    item_history.save
    logger.debug("item added #{item_history}")
    self.item_history << item_history
  end
  
  accepts_nested_attributes_for :flyer
  attr_accessible :flyer, :flyer_attributes
  alias_method :flyer=, :flyer_attributes=
  
end
