class Order < Cachable
  has_many :item_history, :dependent => :destroy
  has_many :flyer, :as => :ordered_by
  has_one :order_info, :dependent => :destroy
  has_one :item_checkout, :dependent => :destroy
  
  def by(flyer)
    update_attribute(:ordered_by, flyer)
  end
  
  def get_item
    item_history
  end
  
  def add_item(item, count, ordered_on)
    logger.debug("adding an item #{item}")
    h_item = ItemHistory.new(:category => item.category,
    :status => Status.get_status(:ordered),
    :barcode => item.barcode,
    :price_ex_gst => item.price_ex_gst)
    h_item.order_count = count
    h_item.ordered_on = ordered_on
    h_item.subtotal_price_ex_gst = item.price_ex_gst * count
    h_item.save
    item.image.each do |image|
      h_image = Image.new(:avatar => File.new(image.original_path),:link_to_url => "", :source_url => "")
      h_image.attached_to(h_item)
    end
    logger.debug("item added #{h_item}")
    self.item_history << h_item
  end
  
  accepts_nested_attributes_for :order_info
  attr_accessible :order_info, :order_info_attributes
  alias_method :order_info=, :order_info_attributes=
  
  #after_save :fix_order
  
  def fix_order
    self.ordered_id = Common.unique_token + "/" + id.to_s
    self.ordered_on = Common.current_time
  end
end
