module ApplicationHelper
  
  def show_cart(animate=nil)
    html = ""
    Rails.logger.debug("animate: #{animate}")
    if @mycart.present?
      html += %Q|<ul class="thumbnails">|
      @mycart.item.each_with_index do |item,i|
        if animate
          css_animate = i == @mycart.item.size-1 ? "thumbnail-fadein" : ""
        else
          css_animate = ""
        end
        html += %Q|<li><div class="thumbnail #{css_animate}" id="mycart-thumbnail-#{item.id}">#{image_tag(item.image.first.thumb_image, :class => "image-resize50_50 img-rounded")}<span>#{image_tag(item.image.first.medium_image, :class => "img-polaroid")}</span></div>|
        html += %Q|<small><p class="text-info">#{number_to_currency(item.price_ex_gst, :locale => "au")}&times;#{@mycart.item_count(item)}|
        html += %Q|#{link_to_with_icon_remote_id("",Enclink.link_to(item.category.name,"remove_from_mycart",{:d => item.id}),"close","","icon-remove-circle icon-white","mycart-thumbnail-remove-#{item.id}")}</p></small></li>|
        html += _script(%Q|$('\#mycart-thumbnail-remove-#{item.id}').click(function(){
          $('\#mycart-thumbnail-#{item.id}').addClass("thumbnail-fadeout");
        })|)
      end
      html += "</ul>"
    end
    html.html_safe
  end

  def show_logo
    html = image_tag("koolbz_logo_L9.png",:class=>"img-rounded", :class => "")
  end
  
  def authorized?
    current_flyer && BeadsKoolbzComAu::Application.config.security[:authorized].include?(current_flyer.email) 
  end
  
end
