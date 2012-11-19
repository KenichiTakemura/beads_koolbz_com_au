class ContactsController < CategoriesController

  layout "contact"
  
  before_filter :filter

  def filter
    @regular = Category.regular
    @special = Category.special
  end
  
  def new

    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    ActiveRecord::Base.transaction do
      if @contact.save
        @contact.set_user(current_flyer) if current_flyer
        ContactMailer.send_contact_to_admin(@contact).deliver
        ContactMailer.send_contact_to_flyer(@contact).deliver
        respond_to do |format|
          format.html { redirect_to about_ozmains_path(:t => "contact"), :notice => t("contact.thank_you")  }
          format.json { render :json => @contact, :status => :created }
        end
      else
        flash[:warning] = I18n.t("failed_to_create")
        @contact.errors.full_messages.each do |msg|
          logger.warn("@contact.errors: #{msg}")
        end
        respond_to do |format|
          format.html { render :action => "new" }
          format.json { render :json => @contact.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  protected

end