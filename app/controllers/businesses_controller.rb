class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
    @businesses = Business.limit(Business::PER_PAGE).offset(params[:offset])
    @pages = Business.page_count
  end

  def show
    @business = Business.find params[:id]
    @reviews = @business.reviews.limit(Review::PER_PAGE).offset(params[:offset])
    @reviews_pages = Review.page_count_by_business @business
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      flash[:success] = "#{@business.name} was created."
      redirect_to businesses_path
    else
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :description)
  end
end
