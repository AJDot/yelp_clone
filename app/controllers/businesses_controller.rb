class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  def index
    @businesses = Business.all.order('name ASC')
  end

  def show
    @business = Business.find params[:id]
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
