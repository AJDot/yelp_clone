shared_examples "require login" do
  before do
    clear_current_user
    action
  end

  it 'redirects to the login path' do
    expect(response).to redirect_to login_path
  end

  it 'sets flash danger message' do
    expect(flash[:danger]).to be
  end
end
