class Category < ActiveRecord::Base

  BARCODE = "KBZ-"

  CATEGORY = Common.new_orderd_hash
  
  CATEGORY[:ring] = ["Ring",false,"beads.ring.headline","beads.ring.leadline",BARCODE + "RG"]
  CATEGORY[:necklace] = ["Necklace",false,"beads.necklace.headline","beads.necklace.leadline",BARCODE + "NS"]
  CATEGORY[:hairpin] = ["Hair Pin",false,"beads.hairpin.headline","beads.hairpin.leadline",BARCODE + "HP"]
  CATEGORY[:bracelet] = ["Bracelet" ,false,"beads.bracelet.headline","beads.bracelet.leadline",BARCODE + "BR"]
  CATEGORY[:hairband] = ["Hair Band",false,"beads.hairband.headline","beads.hairband.leadline",BARCODE + "HB"]
  CATEGORY[:hairelastic] = ["Hair Elastic",false,"beads.hairelastic.headline","beads.hairelastic.leadline",BARCODE + "HE"]
  CATEGORY[:earring] = ["Earring",false,"beads.earring.headline","beads.earring.leadline",BARCODE + "ER"]
  CATEGORY[:character] = ["Character",true,"beads.character.headline","beads.character.leadline",BARCODE + "CR"]
  CATEGORY[:combination] = ["Combination",true,"beads.combination.headline","beads.combination.leadline",BARCODE + "CB"]
  CATEGORY[:season] = ["Season",true,"beads.season.headline","beads.season.leadline",BARCODE + "CE"]

  attr_accessible :name, :special, :headline, :leadline, :open_status, :key
  
  has_many :item
  
  scope :has_item, lambda { joins("left outer join items on items.category_id = categories.id").where("items.category_id is not NULL").group("categories.id") }
  
  scope :special, has_item.where("special = true")
  scope :regular, has_item.where("special != true")
  
  after_initialize :set_default
  
  def set_default
    status = Status.open_status :public
  end
  
  def self.barcode(category)
    CATEGORY[:ring][4]
  end
  
end
