class Carousel < ActiveRecord::Base
  attr_accessible :name, :headline, :leadline

  has_many :image, :as  => :attached, :class_name => 'Image', :dependent => :destroy

  def set_has_image(yesno)
    update_attribute(:has_image, yesno)
  end
  
  def has_image?
    has_image
  end
  
end
