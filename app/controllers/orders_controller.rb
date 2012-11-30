class OrdersController < CategoriesController
  
  layout "order"
  
  def index
    _header
    order_id = params[:d].present? ? Enclink.param_to_i(params[:d]) : nil
    redirect_to root_path and return if !order_id.present?
    @order = Order.find(order_id)
  end
  
  def new
    _header
    #if session[:myorder]
    #  @order = Order.fetch(session[:myorder])
    #else
    #  @order = Order.new
    #  @order.save
    #  session[:myorder] = @order.id
    #end
    #logger.info("new order id: #{session[:myorder]}")
    #if current_flyer && !@order.ordered_by_id.present?
    #  @order.by(current_flyer)
    #end

    respond_to do |format|
      format.html
    end
  end

  def confirm_order
    @order = Order.new
    @order.build_order_info
    if current_flyer
      @order.order_info.user_name = current_flyer.flyer_name
      @order.order_info.email = current_flyer.email
    end
  end
  
  def create
    @order = Order.new(params[:order])
    logger.debug("create order: #{@order}")
    ActiveRecord::Base.transaction do
      # Associate item_checkout to order
      @mycart.ordered(@order)
      @order.ordered_price_ex_gst = @mycart.total_price
      @order.fix_order
      if @order.save
        # Copy all items to order
        @mycart.item.each do |item|
          @order.add_item(item, @mycart.item_count(item), @order.ordered_on)
        end
        # Reset my cart
        session[:mycart] = nil
        #ContactMailer.send_contact_to_admin(@contact).deliver
        #ContactMailer.send_contact_to_flyer(@contact).deliver
        flash[:notice] = I18n.t("order.complete")
        respond_to do |format|
          format.js
          format.json { render :json => @order, :status => :created }
        end
      else
        flash[:warning] = I18n.t("failed_to_create")
        @order.errors.full_messages.each do |msg|
          logger.warn("@order.errors: #{msg}")
        end
        respond_to do |format|
          format.js
          format.json { render :json => @order.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
  private
   
  def _header
    @regular = Category.regular
    @special = Category.special
  end

end
