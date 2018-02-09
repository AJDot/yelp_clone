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
end
