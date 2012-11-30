class ItemsController < AuditsController

  layout "item"
  
  before_filter :prepare
  
  def prepare
    @categories = Category.all
  end
  
  def index
    @category = Category.find_by_name(params[:category])
    @items = Item.category_for_all(@category)
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new
    raise Exceptions::BadRequestError unless params[:category].present?
    category = Category.find_by_name(params[:category])
    @item.category = category
    @item.generate_barcode
    @image = Image.new
    @item.write_at = Common.current_time.to_i
    @image.write_at = @item.write_at
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json =>  @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
    @images = Image.collect_image(current_flyer,@item.write_at)
    logger.debug("create #{@images.size}")  
    respond_to do |format|
      begin
        raise Exception.new(t("item.admin.image_required")) if !@images.present?
        logger.debug("images present.")  
        if @item.save
          logger.debug("item saved. #{@item}")  
          @images.each do |image|
            image.attached_to_by(@item, current_flyer)
          end
          logger.debug("Delete unsaved images")  
          # Delete unsaved images if any
          Image.collect_image(current_flyer,@item.write_at).each do |image|
            logger.info("Image to be deleted. #{image}")
            image.destroy
          end
          logger.debug("create complete")  
          format.html { redirect_to items_path(:category => @item.category.name), :notice => 'Item was successfully created.' }
          format.json { render :json =>  @item, :status => :created, :location => @item }
        else
          @image = Image.new(:write_at => @item.write_at)
          format.html { render :action => "new" }
          format.json { render :json =>  @item.errors, :status => :unprocessable_entity }
        end
      rescue Exception => e
        logger.error("something wrong e => #{$!}")
        flash[:alert] = "#{$!}"
        @image = Image.new(:write_at => @item.write_at)
        format.html { render :action => "new" }
        format.json { render :json =>  @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])
    item_updated = params[:item]
    logger.info("item_updated #{item_updated}")
    sold = Status.find_by_name('Sold').id
    logger.info("sold #{sold}")
    respond_to do |format|
      if @item.update_attributes(item_updated)
        # update sold date if not sold
        logger.info("item_updated[:status_id]: #{item_updated[:status_id]}")
        if(item_updated[:status_id].to_i != sold) 
          logger.info("item is not sold")
          @item.sold = nil 
          @item.save
        else
           logger.info("item is sold")
        end
        format.html { redirect_to items_path(:category => @item.category_id), :notice => 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # Smart Ajax
  def tap_main
    @item = Item.find(params[:d])
    @item.update_attribute(:main, !@item.main)
  end
  
  def tap_open_status
    @item = Item.find(params[:d])
    @item.update_attribute(:open_status, Status.get_next_open_status(@item.open_status))
  end

end
