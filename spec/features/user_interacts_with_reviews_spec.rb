feature 'User interacts with reviews' do
  given(:restaurant) { Fabricate(:business) }

  scenario 'user creates a review for a business and view it on business and user pages' do
    alex = Fabricate(:user)
    login alex

    visit business_path(restaurant)
    click_link 'Write a Review'
    rating = 3
    body = 'This is a review'
    select "#{rating} Stars", from: 'Rating'
    fill_in 'Body', with: body
    click_button 'Create Review'
    expect_review_to_be_present(rating, body)

    click_link alex.full_name
    expect(page).to have_content restaurant.name
    expect_review_to_be_present(rating, body)

    click_link restaurant.name
    expect(page).to have_link 'Write a Review'
  end

  def expect_review_to_be_present(rating, body)
    expect(page).to have_content "#{rating} / 5 stars"
    expect(page).to have_content body
  end
end
