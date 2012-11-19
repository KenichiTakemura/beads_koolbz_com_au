class Category < ActiveRecord::Base

  CATEGORY = Common.new_orderd_hash
  CATEGORY[:ring] = ["Ring",false,"beads.ring.headline","beads.ring.leadline"]
  CATEGORY[:necklace] = ["Necklace",false,"beads.necklace.headline","beads.necklace.leadline"]
  CATEGORY[:hairpin] = ["Hair Pin",false,"beads.hairpin.headline","beads.hairpin.leadline"]
  CATEGORY[:bracelet] = ["Bracelet" ,false,"beads.bracelet.headline","beads.bracelet.leadline"]
  CATEGORY[:hairband] = ["Hair Band",false,"beads.hairband.headline","beads.hairband.leadline"]
  CATEGORY[:hairelastic] = ["Hair Elastic",false,"beads.hairelastic.headline","beads.hairelastic.leadline"]
  CATEGORY[:earring] = ["Earring",false,"beads.earring.headline","beads.earring.leadline"]
  CATEGORY[:character] = ["Character",true,"beads.character.headline","beads.character.leadline"]
  CATEGORY[:combination] = ["Combination",true,"beads.combination.headline","beads.combination.leadline"]

  attr_accessible :name, :special, :headline, :leadline
  
  has_many :item
  
  scope :special, where("special = true")
  scope :regular, where("special != true")
  
end
