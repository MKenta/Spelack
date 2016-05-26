require 'rails_helper'

RSpec.describe JoinChannelsController do
  login_user
  describe 'GET #index' do
    let(:channel) { create(:channel) }
    before { get :index, id: channel.id }

    it { change(assigns(:current_user).channels, :count).by(2) }
    specify { expect(response).to have_http_status(302) }
    specify { expect(response).to redirect_to channels_path }
  end
end
