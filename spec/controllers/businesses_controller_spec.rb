describe BusinessesController do
  describe 'GET index' do
    it 'sets @businesses' do
      business1 = Fabricate(:business, name: 'beta')
      business2 = Fabricate(:business, name: 'alpha')
      get :index
      expect(assigns(:businesses)).to match_array [business1, business2]
    end

    it 'sets @businesses in alphabetical order' do
      business1 = Fabricate(:business, name: 'beta')
      business2 = Fabricate(:business, name: 'alpha')
      get :index
      expect(assigns(:businesses)).to eq([business2, business1])
    end
  end
end
