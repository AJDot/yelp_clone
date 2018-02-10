class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  validates_presence_of :rating, :body

  def self.average_by_business(business)
    reviews = where business: business
    return 0 if reviews.empty?
    (reviews.map(&:rating).sum / reviews.count.to_f).round(1)
  end
end
