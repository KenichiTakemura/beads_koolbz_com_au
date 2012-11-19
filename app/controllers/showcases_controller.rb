class ShowcasesController < CategoriesController
  
  def index
    @regular = Category.regular
    @special = Category.special
    @carousels = Carousel.all
    @categories = Category.all
  end
  
end
