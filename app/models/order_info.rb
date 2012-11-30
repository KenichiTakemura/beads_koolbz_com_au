class OrderInfo < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :order
  
  EMAIL_REGEXP = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  attr_accessible :email, :user_name, :phone, :body
  
  validates_presence_of :email
  validates_presence_of :user_name
  validates_format_of :email, :with => EMAIL_REGEXP, :if => :validate_email
  validates_format_of :phone, :with => /\A[\+\d\-\(\)\sx]+\z/, :if => :validate_phone
  
  def validate_phone
    phone.present?
  end
  
  def validate_email
    email.present?
  end
end
