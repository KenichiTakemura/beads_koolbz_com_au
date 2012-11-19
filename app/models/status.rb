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
end
