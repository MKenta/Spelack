require 'rails_helper'

RSpec.describe MessagesController do
  login_user
  describe 'POST #create' do
    context 'when saving message is success' do
      before { post :create, message: attributes_for(:message) }
      it { change(Message, :count).by(1) }
      specify { expect(response).to have_http_status(:ok) }
    end
    context 'when saving message is not success' do
      before { post :create, message: attributes_for(:message, text: nil) }
      it 'redirects to message' do
        expect(response).to have_http_status(:ok)
      end
      it 'renders to #index' do
        expect(response).to render_template(:index)
      end
    end
  end
  describe 'PATCH #update'
  let(:message) { create(:message) }
  let(:text) { FFaker::BaconIpsum.characters(10) }
  context 'when updating message is success' do
    it 'locates the requersted message' do
      patch :update, id: message, message: attributes_for(:message)
      expect(assigns(:message)).to eq message
      expect(response).to have_http_status(:ok)
    end
    it 'changes messages attributes' do
      patch :update, id: message, message: attributes_for(:message, text: text)
      message.reload
      expect(message.text).to eq text
    end
  end
  context 'when updating message is not success' do
    before { patch :update, id: message, message: attributes_for(:message, text: nil) }
    specify { expect(response).to have_http_status(:bad_request) }
  end
  describe 'DELETE #destroy' do
    let(:message) { create(:message) }
    before { delete :destroy, id: message }
    it { change(Message, :count).by(-1) }
  end
end
