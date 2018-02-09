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
end
