class ItemHistory < ActiveRecord::Base
  attr_accessible :barcode, :price_ex_gst, :category, :status
  validates_presence_of :barcode
  validates_presence_of :price_ex_gst

  belongs_to :category
  belongs_to :order

  has_many :image, :as  => :attached, :class_name => 'Image', :dependent => :destroy

  scope :category_for, lambda { |category| where("category_id = ?", category)}

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

end