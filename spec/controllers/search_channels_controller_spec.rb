require 'rails_helper'

RSpec.describe SearchChannelsController do
  login_user
  shared_examples_for 'http_succses' do |template|
    specify { expect(response).to have_http_status(:ok) }
    specify { expect(response).to render_template template }
  end
  describe 'GET #index' do
    let(:channels) { create_list(:channel, 25) }
    context 'when there is a search word' do
      before { get :index, query: channels[5].name }
      specify { expect(assigns(:channels).to_a).to eq [channels[5]] }
      it_behaves_like 'http_succses', :index
    end

    context 'when the search word does not exist' do
      before do
        general = Channel.find(1)
        channels.unshift(general)
      end
      specify { expect(assigns(:channels)).to eq channels }
      before { get :index }
      it_behaves_like 'http_succses', :index
    end
  end
end
