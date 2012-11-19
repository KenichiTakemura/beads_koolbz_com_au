class LegacyItem < ActiveRecord::Base
  establish_connection "legacy"
  set_table_name "items"

end
