class BusinessesController < ApplicationController
  def index
    @businesses = Business.all.order('name ASC')
  end

  def show
    @business = Business.find params[:id]
  end
end
