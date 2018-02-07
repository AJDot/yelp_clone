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
end
