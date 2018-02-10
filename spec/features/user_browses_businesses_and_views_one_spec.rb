feature 'User browses businesses and views one' do
  background do
    9.times do |n|
      Fabricate(:business, name: "Business #{n}")
    end
  end

  scenario 'user uses pagination buttons to find and view a business' do
    visit root_path
    click_link '3'
    click_link 'Business 8'
    expect(page).to have_content('Business 8')
  end
end
