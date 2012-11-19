class SoldItem < ActiveRecord::Base
  attr_accessible :sold_on, :price_ex_gst, :sold_at, :sold_by
  
  SOLDAT = Common.new_orderd_hash
  SOLDAT[:shop] = ["At Shop",1]
  SOLDAT[:online] = ["Online",2]
  SOLDAT[:friend] = ["Friend",3]
  SOLDBY = Common.new_orderd_hash
  SOLDBY[:shop] = ["At Shop",1]
  SOLDBY[:direct] = ["Direct",2]
  SOLDBY[:online] = ["Online",3]
  
  belongs_to :sold, :polymorphic => true

  def mark_sold(item)
    update_attribute(:sold, item)
  end
  
  def SoldItem.sold_at(at)
    SOLDAT[at][1]
  end
  
  def SoldItem.sold_by(by)
    SOLDBY[by][1]
  end
  
end
