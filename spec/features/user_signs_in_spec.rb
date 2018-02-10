feature 'User signs in' do
  scenario 'with valid email and password' do
    alex = Fabricate(:user)
    login alex
    expect(page).to have_content "Logged in as #{alex.first_name}"
  end
end
