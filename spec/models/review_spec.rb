describe Review do
  it 'belongs to a user' do
    review = Fabricate.build(:review, user: nil)
    review.save
    expect(Review.count).to eq(0)
  end

  it 'belongs to a business' do
    review = Fabricate.build(:review, user: nil)
    review.save
    expect(Review.count).to eq(0)
  end

  it 'must have a body' do
    review = Fabricate.build(:review, body: nil)
    review.save
    expect(Review.count).to eq(0)
  end

  it 'must have a rating' do
    review = Fabricate.build(:review, rating: nil)
    review.save
    expect(Review.count).to eq(0)
  end

  describe 'average_by_business' do
    it 'returns the average rating for the business' do
      business = Fabricate(:business)
      Fabricate(:review, rating: 2, business: business)
      Fabricate(:review, rating: 4, business: business)
      average = Review.average_by_business(business)
      expect(average).to eq(3)
    end

    it 'returns the average rating for the business as a decimal with 1 precision' do
      business = Fabricate(:business)
      Fabricate(:review, rating: 3, business: business)
      Fabricate(:review, rating: 4, business: business)
      Fabricate(:review, rating: 4, business: business)
      average = Review.average_by_business(business)
      expect(average).to eq(3.7)
    end

    it 'returns 0 if there are no ratings' do
      business = Fabricate(:business)
      average = Review.average_by_business(business)
      expect(average).to eq(0)
    end
  end

  describe 'page_count_by_user' do
    let(:user) { Fabricate(:user) }

    it 'returns 0 when user has no reviews' do
      expect(Review.page_count_by_user(user)).to eq(0)
    end

    it 'returns number of pages needed to paginate through all user reviews when review count is evenly divisble by per_page' do
      Fabricate.times(6, :review, user: user)
      expect(Review.page_count_by_user(user)).to eq(2)
    end

    it 'returns number of pages needed to paginate through all user reviews when business count is not evenly divisble by per_page' do
      Fabricate.times(4, :review, user: user)
      expect(Review.page_count_by_user(user)).to eq(2)
    end
  end

  describe 'page_count_by_business' do
    let(:business) { Fabricate(:business) }

    it 'returns 0 when business has no reviews' do
      expect(Review.page_count_by_business(business)).to eq(0)
    end

    it 'returns number of pages needed to paginate through all business reviews when review count is evenly divisble by per_page' do
      Fabricate.times(6, :review, business: business)
      expect(Review.page_count_by_business(business)).to eq(2)
    end

    it 'returns number of pages needed to paginate through all business reviews when business count is not evenly divisble by per_page' do
      Fabricate.times(4, :review, business: business)
      expect(Review.page_count_by_business(business)).to eq(2)
    end
  end
end
