describe User do
  it 'must have a first name' do
    new_user = Fabricate.build(:user, first_name: nil)
    new_user.save
    expect(User.count).to eq(0)
  end

  it 'must have a last name' do
    new_user = Fabricate.build(:user, last_name: nil)
    new_user.save
    expect(User.count).to eq(0)
  end

  it 'must have an email' do
    new_user = Fabricate.build(:user, email: nil)
    new_user.save
    expect(User.count).to eq(0)
  end

  it 'must have a password' do
    new_user = Fabricate.build(:user, password: nil)
    new_user.save
    expect(User.count).to eq(0)
  end

end
