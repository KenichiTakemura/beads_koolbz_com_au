

Carousel.destroy_all
1.upto(6) { |x|
  ca = Carousel.new(:name => "carousel_#{x}")
  ca.save
  ca.update_attribute(:headline, ca.name + ".headline")
  ca.update_attribute(:leadline, ca.name + ".leadline")
  Dir["#{Rails.root}/config/assets/carousel_pictures/#{ca.name}/*"].each do |filename|
    # skip profile name
    next if File.directory?(filename)
    puts "Importing #{filename} to #{ca.name}"
    image = Image.new(:avatar => File.new(filename),:link_to_url => "", :source_url => "")
    image.attached_to(ca)
  end
}

Category.destroy_all
Category::CATEGORY.each do |k,v|
  cate = Category.create(:key => k, :name => v[0], :special => v[1], :headline => v[2], :leadline => v[3], :open_status => Status.open_status(:public))
end

#|  1 | In Stock  | 2012-07-16 10:37:05 | 2012-07-16 10:37:05 |
#|  2 | At MyCube | 2012-07-16 10:37:05 | 2012-07-16 10:37:05 |
#|  3 | Sold      | 2012-07-16 10:37:05 | 2012-07-16 10:37:05 |
#|  4 | Withdrawn | 2012-07-16 10:37:05 | 2012-07-16 10:37:05 |
#|  5 | Pre Order | 2012-07-16 10:37:05 | 2012-07-16 10:37:05 |

Item.destroy_all
LegacyItem.all.each do |item|
  case item.barcode
  when /^KBZ-RG.*\z/
    kate = :ring
    cate = Category.find_by_name(Category::CATEGORY[:ring])
  when /^KBZ-NS.*\z/
    kate = :necklace
    cate = Category.find_by_name(Category::CATEGORY[:necklace])
  when /^KBZ-HP.*\z/
    kate = :hairpin
    cate = Category.find_by_name(Category::CATEGORY[:hairpin])
  when /^KBZ-HB.*\z/
    kate = :hairband
    cate = Category.find_by_name(Category::CATEGORY[:hairband])
  when /^KBZ-HE.*\z/
    kate = :hairelastic
    cate = Category.find_by_name(Category::CATEGORY[:hairelastic])
  when /^KBZ-EA.*\z/
    kate = :earring
    cate = Category.find_by_name(Category::CATEGORY[:earring])
  when /^KBZ-BR.*\z/
    kate = :bracelet
    cate = Category.find_by_name(Category::CATEGORY[:bracelet])
  end
  i = Item.new(:barcode => item.barcode, :price_ex_gst => item.price_ex_gst)
  i.open_status = Status.open_status(:private)
  i.barcode_ordered = item.barcode_ordered
  i.status = item.status_id
  i.save
  if item.sold.present?
    sold = SoldItem.new(:sold_on => item.sold, :price_ex_gst => item.price_ex_gst, :sold_at => SoldItem.sold_at(:shop), :sold_by => SoldItem.sold_by(:shop))
    sold.mark_sold(i)
  end
  i.extra = item.avatar_file_name
  i.set_category(cate)

  Dir["#{Rails.root}/config/assets/item_pictures/#{kate}/*"].each do |filename|
    if filename =~ /#{item.barcode}.*\z/
      puts "Importing #{filename} to #{cate.name}"
      image = Image.new(:avatar => File.new(filename),:link_to_url => "", :source_url => "")
      image.attached_to(i)
    end
  end

end