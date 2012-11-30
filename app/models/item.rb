class Item < ActiveRecord::Base
  attr_accessible :barcode, :price_ex_gst, :category_id, :barcode_ordered
  attr_accessible :soldm, :write_at
  validates_presence_of :barcode
  validates_uniqueness_of :barcode
  #validates_presence_of :price_ex_gst

  belongs_to :category

  has_many :image, :as  => :attached, :class_name => 'Image', :dependent => :destroy
  has_many :sold_item, :as  => :sold, :class_name => 'SoldItem', :dependent => :destroy

  # many-to-many
  has_many :item_cart
  has_many :item_checkout, :dependent => :destroy, :through => :item_cart
  
  scope :for_sale, lambda { |category| category_for(category).is_public.where("price_ex_gst is not NULL") }
  scope :category_for, lambda { |category| where("category_id = ?", category).is_public }
  scope :is_public, where("open_status = ?", Status.open_status(:public))
  scope :main_item, where("main = true").limit(1)
  
  scope :category_for_all, lambda { |category| where("category_id = ?", category) }
  
  before_save :calc_gst, :set_default
  
  def set_default
    self.status ||= Status.get_status(:instock)
    self.open_status ||= Status.open_status(:private)
    logger.debug("set_default: #{status} #{open_status}")
  end
  
  def generate_barcode
    self.barcode = "#{Category.barcode(self.category.key.to_sym)}#{self.category.item.size+1}" 
  end
  
  def calc_gst
    if price_ex_gst.present?
      self.gst = price_ex_gst * 0.1
      self.price_inc_gst = price_ex_gst + self.gst
    end
  end

  def set_category(cate)
    update_attribute(:category, cate)
  end
  
  def set_has_image(yesno)
    update_attribute(:has_image, yesno)
  end
  
  def has_image?
    has_image
  end
  
  def to_s
    "#{id} #{category} #{barcode} #{price_ex_gst}"
  end

  def viewed
    update_attribute(:views, views + 1)
  end
  
  def total_price(count)
    price_ex_gst * count.to_i
  end
  
  def open?
    presence && has_image && open_status == Status.open_status(:public) 
  end
  
end
