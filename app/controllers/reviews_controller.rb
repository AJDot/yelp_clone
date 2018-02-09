class ReviewsController < ApplicationController
  before_action :require_user

  def new
    @business = Business.find params[:business_id]
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @business = Business.find params[:business_id]
    @review.business = @business
    @review.user = current_user
    if @review.save
      flash[:success] = 'Review successfully created.'
      redirect_to business_path(@business)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
