describe Business do
  it 'must have a name' do
    new_user = Fabricate.build(:business, name: nil)
    new_user.save
    expect(Business.count).to eq(0)
  end

  it 'must have a description' do
    new_user = Fabricate.build(:business, description: nil)
    new_user.save
    expect(Business.count).to eq(0)
  end

  it 'has many reviews' do
    business = Fabricate(:business)
    Fabricate(:review, business: business)
    Fabricate(:review, business: business)
    expect(Business.first.reviews.count).to eq(2)
  end

  it 'has many reviews in descending order by created_at' do
    business = Fabricate(:business)
    review1 = Fabricate(:review, business: business, created_at: 1.day.ago)
    review2 = Fabricate(:review, business: business)
    expect(Business.first.reviews).to eq([review2, review1])
  end
end
