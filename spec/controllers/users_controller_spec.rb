describe UsersController do
  describe 'GET new' do
    it 'sets @user to new User' do
      get :new
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'GET show' do
    it 'sets @user' do
      user = Fabricate(:user)
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
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
