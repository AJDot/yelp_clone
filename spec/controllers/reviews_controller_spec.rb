describe ReviewsController do
  describe 'GET new' do
    let(:business) { Fabricate(:business) }

    before do
      set_current_user
      get :new, params: { business_id: business.id }
    end

    it 'sets @user' do
      expect(assigns(:user)).to eq(current_user)
    end

    it 'sets @business' do
      expect(assigns(:business)).to eq(business)
    end

    it 'sets @review to a new review' do
      expect(assigns(:review)).to be_a_new Review
    end
  end

  describe 'POST create' do
    context 'with valid inputs' do
      it 'creates a review' do
        business = Fabricate(:business)
        alice = Fabricate(:user)
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id, user_id: alice.id }
        expect(Review.count).to eq(1)
      end

      it 'creates a review associated with a user' do
        business = Fabricate(:business)
        alice = Fabricate(:user)
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id, user_id: alice.id }
        expect(Review.first.user).to eq(alice)
      end

      it 'creates a review associated with a business' do
        business = Fabricate(:business)
        alice = Fabricate(:user)
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id, user_id: alice.id }
        expect(Review.first.business).to eq(business)
      end

      it 'sets the flash success message' do
        business = Fabricate(:business)
        alice = Fabricate(:user)
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id, user_id: alice.id }
        expect(flash[:success]).to be
      end

      it 'redirects to the show business path' do
        business = Fabricate(:business)
        alice = Fabricate(:user)
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id, user_id: alice.id }
        expect(response).to redirect_to business_path(business)
      end
    end

    context 'with invalid inputs' do
      it 'does not create a review' do
        business = Fabricate(:business)
        alice = Fabricate(:user)
        post :create, params: { review: Fabricate.attributes_for(:review, body: ""), business_id: business.id, user_id: alice.id }
        expect(Review.count).to eq(0)
      end

      it 'renders the new template' do
        business = Fabricate(:business)
        alice = Fabricate(:user)
        post :create, params: { review: Fabricate.attributes_for(:review, body: ""), business_id: business.id, user_id: alice.id }
        expect(response).to render_template :new
      end

      it 'sets @review' do
        business = Fabricate(:business)
        alice = Fabricate(:user)
        review_params = Fabricate.attributes_for(:review, body: "")
        post :create, params: { review: review_params, business_id: business.id, user_id: alice.id }
        expect(assigns(:review)).to be_a_new Review
        expect(assigns(:review).user_id).to eq(alice.id)
      end

      it 'sets @business' do
        business = Fabricate(:business)
        alice = Fabricate(:user)
        review_params = Fabricate.attributes_for(:review, body: "")
        post :create, params: { review: review_params, business_id: business.id, user_id: alice.id }
        expect(assigns(:business)).to eq(business)
      end

      it 'sets @user' do
        business = Fabricate(:business)
        alice = Fabricate(:user)
        review_params = Fabricate.attributes_for(:review, body: "")
        post :create, params: { review: review_params, business_id: business.id, user_id: alice.id }
        expect(assigns(:user)).to eq(alice)
      end
    end
  end
end
