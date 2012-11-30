class Status < ActiveRecord::Base

  STATUS = Common.new_orderd_hash
  STATUS[:instock] = ["In Stock",1]
  STATUS[:mycube] = ["At MyCube",2]
  STATUS[:withdrawn] = ["Withdrawn",4]
  STATUS[:preorder] = ["Pre Order",5]
  STATUS[:barcode] = ["Barcode In Request",6]
  STATUS[:making] = ["Makeing",7]
  
  STATUS[:await_order] = ["On Review",10]
  STATUS[:ordered] = ["Ordered",11]
  
  OPEN_STATUS = Common.new_orderd_hash
  OPEN_STATUS[:public] = ["Public",1]
  OPEN_STATUS[:private] = ["Private",2]
  
  def self.get_status(s)
    STATUS[s][1]
  end
  
  def self.open_status(s)
    OPEN_STATUS[s][1]
  end
  
  def self.get_status_str(n)
    STATUS.each do |k,v|
      return v[0] if v[1] == n
    end
    ""
  end

  def self.get_open_status_str(n)
    OPEN_STATUS.each do |k,v|
      return v[0] if v[1] == n
    end
    ""
  end
  
  def self.get_next_open_status(n)
    nt = n + 1
    if nt > OPEN_STATUS.size
        nt = 1
    end
    nt
  end

end
