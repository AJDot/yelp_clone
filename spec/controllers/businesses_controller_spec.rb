describe BusinessesController do
  describe 'GET index' do
    let(:business1) { Fabricate(:business, name: 'alpha', created_at: 1.day.ago) }
    let(:business2) { Fabricate(:business, name: 'beta') }

    before { get :index }

    it 'sets @businesses' do
      expect(assigns(:businesses)).to match_array [business1, business2]
    end

    it 'sets @businesses in alphabetical order' do
      expect(assigns(:businesses)).to eq([business1, business2])
    end
  end

  describe 'GET show' do
    it 'sets @business' do
      business = Fabricate(:business)
      get :show, params: { id: business.id }
      expect(assigns(:business)).to eq(business)
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
