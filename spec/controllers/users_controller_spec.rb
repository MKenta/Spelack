require 'rails_helper'

describe UsersController do
  shared_examples_for 'http_succses' do |template|
    specify { expect(response).to have_http_status(:ok) }
    specify { expect(response).to render_template template }
  end

  login_user
  describe 'login user' do
    describe 'GET #index' do
      # ログインできた時にindexページに遷移するか
      context 'by login user' do
        before { get :index }
        it_behaves_like 'http_succses', :index
      end

      context 'should have a current_user' do
        specify { expect(subject.current_user).to_not eq(nil) }
      end

      context 'should get index' do
        before { get :index }
        specify { expect(response).to be_success }
      end
    end
  end
end
