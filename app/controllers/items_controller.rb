class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    if params[:status] && params[:status] != ''
        # ignore category
       @items = Item.where(:status_id => params[:status])
    elsif params[:category] && params[:category] != ''
      @items = Item.where(:category_id => params[:category])
    else
      @items = Item.all
    end
    @category = params[:category]
    @status = params[:status]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new
    @item.category_id  = params[:category] if params[:category]
    @item.status_id = Status.find_by_name("In Stock")
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
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
    respond_to do |format|
      if @item.save
        format.html { redirect_to items_path(:category => @item.category_id), notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
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
        format.html { redirect_to items_path(:category => @item.category_id), notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
  
  def upload
    _file = params[:file]
    logger.debug("original_filename: #{_file.original_filename}")
    logger.debug("content_type: #{_file.content_type}")
    logger.debug("tempfile: #{_file.tempfile.path}")
    logger.debug("size: #{_file.size}")
    _name = _file.original_filename
    session[:upload_tmp_files] = _name
    logger.debug("session[:upload_tmp_files]: #{session[:upload_tmp_files]}")    
    data = request.raw_post
    @file_content = File.open("#{Rails.root.to_s}/tmp/#{_name}", "wb") do |f| 
      f.write(data)
    end
    item = Item.new(:avatar => _file)
    item.save
    #File.unlink("#{Rails.root.to_s}/tmp/#{_name}")
    render :json => {:result => 'Success'}
  end
end
