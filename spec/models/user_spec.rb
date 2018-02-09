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

  it 'must have a unique email' do
    alice = Fabricate(:user)
    bob = Fabricate.build(:user, email: alice.email)
    bob.save
    expect(User.count).to eq(1)
  end

  it 'must have a password on create' do
    new_user = Fabricate.build(:user, password: nil)
    new_user.save
    expect(User.count).to eq(0)
  end

  it 'must have a password confirmation on create' do
    new_user = Fabricate.build(:user, password: 'password', password_confirmation: '')
    new_user.save
    expect(User.count).to eq(0)
  end

  it 'has many reviews' do
    alice = Fabricate(:user)
    Fabricate(:review, user: alice)
    Fabricate(:review, user: alice)
    expect(User.first.reviews.count).to eq(2)
  end
end
