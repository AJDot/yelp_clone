class Review < ActiveRecord::Base
  PER_PAGE = 3

  belongs_to :user
  belongs_to :business

  validates_presence_of :rating, :body

  def self.average_by_business(business)
    reviews = where business: business
    return 0 if reviews.empty?
    (reviews.map(&:rating).sum / reviews.count.to_f).round(1)
  end

  def self.page_count_by_user(user)
    (where(user: user).count - 1) / PER_PAGE + 1
  end

  def self.page_count_by_business(business)
    (where(business: business).count - 1) / PER_PAGE + 1
  end
end
