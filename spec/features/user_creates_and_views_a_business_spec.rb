feature 'User creates and views a business' do
  scenario 'with valid inputs' do
    login

    click_link 'Create a Business'
    fill_in 'Name', with: 'New Business'
    fill_in 'Description', with: 'This is a business.'
    click_button 'Create Business'
    expect(page).to have_content 'New Business'

    click_link 'New Business'
    expect(page).to have_content 'Reviews for New Business'
  end

  scenario 'with invalid inputs' do
    login

    click_link 'Create a Business'
    fill_in 'Name', with: ''
    fill_in 'Description', with: ''
    click_button 'Create Business'
    expect(page).to have_selector "form[action='#{businesses_path}']"
  end
end
