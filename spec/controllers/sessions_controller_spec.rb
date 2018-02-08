describe SessionsController do
  describe 'POST create' do
    context 'with valid credentials' do
      let(:alice) { Fabricate(:user) }

      before do
        post :create, params: { email: alice.email, password: alice.password }
      end

      it 'sets the user in the session' do
        expect(session[:user_id]).to eq(alice.id)
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid credentials' do
      let(:alice) { Fabricate(:user) }

      before do
        post :create, params: { email: alice.email, password: alice.password + '1' }
      end

      it 'does not set the user in the session' do
        expect(session[:user_id]).to be_nil
      end

      it 'sets the flash danger message' do
        expect(flash[:danger]).to be
      end

      it 'redirects to the sign in page' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      set_current_user
      delete :destroy
    end

    it 'clears the user from the session' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to root_path
    end

    it 'sets the flash success message' do
      expect(flash[:success]).to be
    end
  end
end
