module FlyerHelper
  
  def show_flyer_header(flyer=nil)
    return "" if flyer.nil? && !current_flyer
    if flyer.nil?
      flyer = current_flyer
    end
    if flyer.flyer_image.present?
      html = image_tag(flyer.flyer_image, :alt => "")
    else
      html = flyer.flyer_name
    end
    html.html_safe
  end
end
