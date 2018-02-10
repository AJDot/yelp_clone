class Business < ActiveRecord::Base
  PER_PAGE = 3

  default_scope { order('name ASC') }

  has_many :reviews, -> { order('created_at DESC') }
  validates_presence_of :name, :description

  def self.page_count
    (count - 1) / PER_PAGE + 1
  end
end
