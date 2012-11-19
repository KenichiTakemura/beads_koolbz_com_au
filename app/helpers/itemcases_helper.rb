module ItemcasesHelper
  
  def show_total_price
    html = %Q|#{t("order.total_price")}&nbsp;:&nbsp;#{number_to_currency(@mycart.total_price, :locale => "au")}|
    html.html_safe
  end
  
  def show_item_focused(item)
    html = %Q|#{item.barcode}&nbsp;#{link_to_with_icon_remote(t("op.gotocart"),Enclink.link_to(@category,"addto_cart",:d => item.id),"btn btn-primary btn-small","","icon-plus icon-white")}|
    html += %Q|&nbsp;<i class="icon-shopping-cart icon-white"></i><small>#{t("op.inmycart")}</small>|
    html.html_safe
  end
  
  def show_item_outfocused(item)
    html = %Q|#{item.barcode}&nbsp;#{link_to_with_icon_remote(t("op.gotocart"),Enclink.link_to(@category,"addto_cart",:d => item.id),"btn btn-primary btn-small","","icon-plus icon-white")}|
    html.html_safe
  end
  
  def show_checkout()
      if @mycart.present? && @mycart.item.present?
        html = %Q|<a href="#{new_order_path}" >#{t("op.checkout")}</a>|
      else
        html = ""
      end
    html.html_safe
  end
  
  def show_itemcase(items, i)
    html = ""
    if items.present?
      (i-1).upto(i+1) { |x|
      item = items[x]
      if item.present?
        if x == i
          html += %Q|<li class="span5 box_shadow">|
          html += %Q|<h2 class="text-info text-center" id="item-focused-#{item.id}">|
          if @mycart.present? && @mycart.item.present? && @mycart.item.include?(item)
            html += show_item_focused(item)
          else
            html += show_item_outfocused(item)
          end
        else
          html += %Q|<li class="span3 box_shadow box_opacity">|
          html += %Q|<h2 class="text-info text-center">#{item.barcode}|
        end
        html += "</h2>"
        if item.image.first.present?
        html += %Q|#{image_tag(item.image.first.original_image, :class => "")}|
        end
        html += "</li>"
      end
    }
    end
    html.html_safe
  end
  
  def show_itemdesc(item)
    html = ""
    html += content_tag :blockquote do
      content_tag :dl, :class => "dl-horizontal text-info" do
        content_tag(:dt, t("item.barcode")) +
        content_tag(:dd, item.barcode) +
        content_tag(:dt, t("item.price")) +
        content_tag(:dd, number_to_currency(item.price_ex_gst, :locale => "au"))
      end
    end
    if current_flyer
      html += content_tag(:p, link_to("#{t("op.update")}","#", :class => "btn"))
    end
    html.html_safe
  end
end
