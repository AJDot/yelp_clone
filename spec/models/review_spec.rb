describe Review do
  it 'must belong to a user' do
    review = Fabricate.build(:review, user: nil)
    review.save
    expect(User.count).to eq(0)
  end

  it 'must belong to a business' do
    review = Fabricate.build(:review, user: nil)
    review.save
    expect(User.count).to eq(0)
  end

  it 'must have a body' do
    review = Fabricate.build(:review, body: nil)
    review.save
    expect(User.count).to eq(0)
  end

  it 'must have a rating' do
    review = Fabricate.build(:review, rating: nil)
    review.save
    expect(User.count).to eq(0)
  end
end
