class Contact < ActiveRecord::Base

  CONTACT_lIST = [
    "contact.contact_type.banner",
    "contact.contact_type.general",
    "contact.contact_type.feedback",
    "contact.contact_type.request",
    "contact.contact_type.issue",
    "contact.contact_type.career",
    "contact.contact_type.design",
    "contact.contact_type.buy"
    ]

  DB_CONTACT_LENGTH = 65535
  EMAIL_REGEXP = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  # belongs_to
  belongs_to :contacted_by, :polymorphic => true

  attr_accessible :email, :user_name, :phone, :contact_type, :body
  
  validates_presence_of :email
  validates_presence_of :user_name
  validates_presence_of :contact_type
  validates_presence_of :body
  validates_format_of :email, :with => EMAIL_REGEXP, :if => :validate_email
  validates_format_of :phone, :with => /\A[\+\d\-\(\)\sx]+\z/, :if => :validate_phone

  def validate_phone
    phone.present?
  end
  
  def validate_email
    email.present?
  end

  def category_list()
    list = Array.new
    CONTACT_lIST.each_with_index do |c,i|
      list.push([I18n.t(c), i])
    end
    list
  end
  
  def self.type?(letter)
    CONTACT_lIST.index letter
  end
  
  def title(type)
    I18n.t(CONTACT_lIST[type])
  end
  
  def set_user(user)
    update_attribute(:contacted_by, user)
  end
  
end