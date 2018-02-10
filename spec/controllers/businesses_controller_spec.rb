describe BusinessesController do
  describe 'GET index' do

    it 'sets @businesses to 3 businesses if 3 or more exist' do
      Fabricate.times(3, :business)
      get :index
      expect(assigns(:businesses).count).to eq(3)
    end

    it 'sets @businesses to all business if less than 3 exist' do
      Fabricate.times(2, :business)
      get :index
      expect(assigns(:businesses).count).to eq(2)
    end

    it 'sets @businesses in alphabetical ordered by name ascending' do
      alpha = Fabricate(:business, name: 'alpha', created_at: 4.day.ago)
      beta = Fabricate(:business, name: 'beta', created_at: 3.day.ago)
      gamma = Fabricate(:business, name: 'gamma', created_at: 2.day.ago)
      delta = Fabricate(:business, name: 'delta', created_at: 1.day.ago)
      get :index
      expect(assigns(:businesses)).to eq([alpha, beta, delta])
    end

    it 'sets @pages to number needed to paginate through all businesses' do
      Fabricate.times(5, :business)
      get :index
      expect(assigns(:pages)).to eq(2)
    end

    it 'sets @businesses at correct offset' do
      alpha = Fabricate(:business, name: 'alpha', created_at: 4.day.ago)
      beta = Fabricate(:business, name: 'beta', created_at: 3.day.ago)
      gamma = Fabricate(:business, name: 'gamma', created_at: 2.day.ago)
      delta = Fabricate(:business, name: 'delta', created_at: 1.day.ago)
      get :index, params: { offset: 3 }
      expect(assigns(:businesses)).to eq([gamma])
    end
  end

  describe 'GET show' do
    let(:business) { Fabricate(:business) }

    it 'sets @business' do
      get :show, params: { id: business.id }
      expect(assigns(:business)).to eq(business)
    end

    it 'sets @reviews to 3 reviews if 3 or more exist for business' do
      Fabricate.times(3, :review, business: business)
      get :show, params: { id: business.id }
      expect(assigns(:reviews).count).to eq(3)
    end

    it 'sets @reviews to all reviews if less than 2 exist for business' do
      Fabricate.times(2, :review, business: business)
      get :show, params: { id: business.id }
      expect(assigns(:reviews).count).to eq(2)
    end

    it 'sets @reviews_pages to number needed to paginate through all business reviews' do
      Fabricate.times(5, :review, business: business)
      get :show, params: { id: business.id }
      expect(assigns(:reviews_pages)).to eq(2)
    end

    it 'sets @reviews at correct offset' do
      alpha = Fabricate(:review, business: business, created_at: 4.day.ago)
      beta = Fabricate(:review, business: business, created_at: 3.day.ago)
      gamma = Fabricate(:review, business: business, created_at: 2.day.ago)
      delta = Fabricate(:review, business: business, created_at: 1.day.ago)
      get :show, params: { id: business.id, offset: 3 }
      expect(assigns(:reviews)).to eq([alpha])
    end
  end

  describe 'GET new' do
    context 'with authenticated user' do
      it 'sets @business to new Business' do
        set_current_user
        get :new
        expect(assigns(:business)).to be_a_new Business
      end
    end

    it_behaves_like 'require login' do
      let(:action) do
        get :new
      end
    end
  end

  describe 'POST create' do
    context 'with authenticated user' do
      before { set_current_user }

      context 'with valid inputs' do
        before do
          post :create, params: { business: Fabricate.attributes_for(:business) }
        end

        it 'creates a new business' do
          expect(Business.count).to eq(1)
        end

        it 'redirects to the business index path' do
          expect(response).to redirect_to businesses_path
        end

        it 'sets the flash success message' do
          expect(flash[:success]).to be
        end
      end

      context 'with invalid inputs' do
        before do
          post :create, params: { business: Fabricate.attributes_for(:business, name: "") }
        end

        it 'does not create a new business' do
          expect(Business.count).to eq(0)
        end

        it 'renders the :new template' do
          expect(response).to render_template :new
        end

        it 'sets @business' do
          expect(assigns(:business)).to be_a_new Business
        end
      end
    end

    it_behaves_like 'require login' do
      let(:action) do
        post :create
      end
    end
  end
end
