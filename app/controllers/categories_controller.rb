class CategoriesController < ApplicationController
  
  before_filter :mycart
  
  protected
    
  def mycart
    if session[:mycart].present?
      begin
        @mycart = ItemCheckout.find(session[:mycart])
      rescue
        session[:mycart] = nil
        @mycart = nil
      end
    end
  end
end
