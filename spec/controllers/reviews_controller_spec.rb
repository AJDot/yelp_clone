describe ReviewsController do
  describe 'GET new' do
    context 'with authenticated user' do
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

    it_behaves_like 'require login' do
      let(:business) { Fabricate(:business) }
      let(:action) { get :new, params: { business_id: business.id } }
    end
  end

  describe 'POST create' do
    context 'with authenticated user' do
      before { set_current_user }

      context 'with valid inputs' do
        let(:business) { Fabricate(:business) }
        before do
          post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
        end

        it 'creates a review' do
          expect(Review.count).to eq(1)
        end

        it 'creates a review associated with a user' do
          expect(Review.first.user).to eq(current_user)
        end

        it 'creates a review associated with a business' do
          expect(Review.first.business).to eq(business)
        end

        it 'sets the flash success message' do
          expect(flash[:success]).to be
        end

        it 'redirects to the show business path' do
          expect(response).to redirect_to business_path(business)
        end
      end

      context 'with invalid inputs' do
        let(:business) { Fabricate(:business) }
        before do
          review_params = Fabricate.attributes_for(:review, body: "")
          post :create, params: { review: review_params, business_id: business.id }
        end

        it 'does not create a review' do
          expect(Review.count).to eq(0)
        end

        it 'renders the new template' do
          expect(response).to render_template :new
        end

        it 'sets @review' do
          expect(assigns(:review)).to be_a_new Review
          expect(assigns(:review).user_id).to eq(current_user.id)
        end

        it 'sets @business' do
          expect(assigns(:business)).to eq(business)
        end

        it 'sets @user' do
          expect(assigns(:user)).to eq(current_user)
        end
      end
    end

    it_behaves_like 'require login' do
      let(:action) do
        post :create, params: { review: Fabricate.attributes_for(:review), business_id: Fabricate(:business).id }
      end
    end
  end
end
