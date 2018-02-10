class Business < ActiveRecord::Base
  PER_PAGE = 3

  default_scope { order('name ASC') }

  has_many :reviews, -> { order('created_at DESC') }
  validates_presence_of :name, :description
end
