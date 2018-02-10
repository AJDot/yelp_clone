describe UsersController do
  describe 'GET new' do
    it 'sets @user to new User' do
      get :new
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'GET show' do
    let(:user) { Fabricate(:user) }

    it 'sets @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'sets @reviews to 3 reviews if 3 or more exist for user' do
      Fabricate.times(3, :review, user: user)
      get :show, params: { id: user.id }
      expect(assigns(:reviews).count).to eq(3)
    end

    it 'sets @reviews to all reviews if less than 2 exist for user' do
      Fabricate.times(2, :review, user: user)
      get :show, params: { id: user.id }
      expect(assigns(:reviews).count).to eq(2)
    end

    it 'sets @reviews_pages to number needed to paginate through all user reviews' do
      Fabricate.times(5, :review, user: user)
      get :show, params: { id: user.id }
      expect(assigns(:reviews_pages)).to eq(2)
    end

    it 'sets @reviews at correct offset' do
      alpha = Fabricate(:review, user: user, created_at: 4.day.ago)
      beta = Fabricate(:review, user: user, created_at: 3.day.ago)
      gamma = Fabricate(:review, user: user, created_at: 2.day.ago)
      delta = Fabricate(:review, user: user, created_at: 1.day.ago)
      get :show, params: { id: user.id, offset: 3 }
      expect(assigns(:reviews)).to eq([alpha])
    end
  end

  describe 'POST create' do
    context 'with valid inputs' do
      before do
        post :create, params: { user: Fabricate.attributes_for(:user) }
      end

      it 'creates a new user' do
        expect(User.count).to eq(1)
      end

      it 'signs in the newly created user' do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it 'redirects to the businesses index page' do
        expect(response).to redirect_to businesses_path
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be
      end
    end

    context 'with invalid inputs' do
      let(:user) { Fabricate.build(:user, first_name: "") }
      before do
        post :create, params: { user: user.attributes }
      end

      it 'does not create a new user' do
        expect(User.count).to eq(0)
      end

      it 'sets @user to new User with params from form' do
        expect(assigns(:user)).to be_instance_of User
        expect(assigns(:user).first_name).to eq("")
        expect(assigns(:user).email).to eq(user.email)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end
end
