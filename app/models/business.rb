class Business < ActiveRecord::Base
  has_many :reviews, -> { order('created_at DESC') }
  validates_presence_of :name, :description
end
