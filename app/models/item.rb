class Item < ActiveRecord::Base
  attr_accessible :barcode, :price_ex_gst, :category_id, :barcode_ordered
  attr_accessible :sold
  validates_uniqueness_of :barcode
  validates_presence_of :price_ex_gst

  belongs_to :category

  has_many :image, :as  => :attached, :class_name => 'Image', :dependent => :destroy
  has_many :sold_item, :as  => :sold, :class_name => 'SoldItem', :dependent => :destroy

  # many-to-many
  has_many :item_cart
  has_many :item_checkout, :dependent => :destroy, :through => :item_cart
  
  scope :category_for, lambda { |category| where("category_id = ?", category)}

  before_save :calc_gst
  

  def calc_gst
    self.gst = self.price_ex_gst * 0.1
    self.price_inc_gst = self.price_ex_gst + self.gst
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
    "#{id} #{category.name} #{barcode} #{price_ex_gst}"
  end

  def viewed
    update_attribute(:views, views + 1)
  end
end
