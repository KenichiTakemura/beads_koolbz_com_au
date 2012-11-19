class OrdersController < CategoriesController
  
  layout "order"
  
  def new
    @regular = Category.regular
    @special = Category.special
    if session[:myorder]
      @order = Order.fetch(session[:myorder])
    else
      @order = Order.new
      @order.save
      session[:myorder] = @order.id
    end
    logger.info("new order id: #{session[:myorder]}")
    if current_flyer && !@order.ordered_by_id.present?
      @order.by(current_flyer)
    end
    @mycart.item.each do |item|
      @order.add_item(item)
    end
    respond_to do |format|
      format.html
    end
  end

  
  private
    
end
