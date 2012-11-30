class ItemcasesController < CategoriesController
  
  layout "itemcase"
  
  before_filter :_before_, :except => [:clear_mycart,:order_count]
  
  def _before_
    raise "Bad Request" if params[:v].nil?
    logger.debug("v: #{params[:v]} d: #{params[:d]}")
    @@board = Enclink.param_v(params[:v])
    redirect_to root_path and return if !@@board.present?
    @@item_id = params[:d].present? ? Enclink.param_to_i(params[:d]) : nil
    logger.debug("board: #{@@board} board_id: #{@@item_id}")
    @category = @@board.to_sym
  end
  
  
  def index
    @regular = Category.regular
    @special = Category.special
    
    @category = Category.find_by_name(@@board)
    @items = Item.for_sale(@category)
    logger.debug("@items: #{@items}")
    respond_to do |format|
      format.html
    end
  end
  
  def flip_item
    item_id = params[:p].split("_")[1]
    @item = Item.find(item_id)
    @item.viewed
    respond_to do |format|
      format.js
    end
  end
  
  def addto_cart
    @item = Item.find(@@item_id)
    if !session[:mycart].present?
      @mycart = ItemCheckout.new
      @mycart.save
      session[:mycart] = @mycart.id
    else
      @mycart = ItemCheckout.fetch(session[:mycart])
    end
    @mycart.add_order(@item)
    if current_flyer
      @mycart.by(current_flyer)
    end
  end
  
  def remove_from_mycart
    @item = Item.find(@@item_id)
    if session[:mycart].present?
      @mycart = ItemCheckout.fetch(session[:mycart])
      @mycart.remove_order(@item)
    end
    respond_to do |format|
      format.js
    end
  end
  
  def clear_mycart
    if session[:mycart].present?
      @items = @mycart.item
      logger.debug("clear_mycart: #{@items}")
      @mycart = ItemCheckout.fetch(session[:mycart])
      @mycart.clear_order
    end
    respond_to do |format|
      format.js
    end    
  end
  
  def order_count
    @item = Item.find(params[:id])
    @count = params[:count]
    logger.debug("order_count #{@item} #{@count}")
    if session[:mycart].present?
      @mycart = ItemCheckout.fetch(session[:mycart])
      @mycart.add_order(@item,@count)
      if current_flyer
        @mycart.by(current_flyer)
      end
    end
  end
  
  private
    
end
