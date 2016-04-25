require 'rails_helper'

RSpec.describe ChannelsController do
  shared_examples_for 'http_succses' do |template|
    specify { expect(response).to have_http_status(:ok) }
    specify { expect(response).to render_template template }
  end
  describe 'POST #create' do
    context 'when saving channel is success' do
      before { post :create, channel: attributes_for(:channel) }
      it { change(Channel, :count).by(2) }
      specify { expect(response).to have_http_status(302) }
      specify { expect(response).to redirect_to channel_path(assigns(:channel).id) }
    end
    context 'when saving channel is not success' do
      before { post :create, channel: attributes_for(:channel, name: nil) }
      it_behaves_like 'http_succses', :new
    end
  end
  describe 'GET #index' do
    before { get :index }
    it_behaves_like 'http_succses', :index
  end
  describe 'GET #new' do
    before { get :new }
    it_behaves_like 'http_succses', :new
  end
  describe 'GET #show' do
    let(:channel) { create(:channel) }
    before { get :show, id: channel }
    specify { expect(assigns(:channel)).to eq channel }
    it_behaves_like 'http_succses', :show
  end
end
