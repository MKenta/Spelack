require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    subject { build(:user) }
    describe 'nickname' do
      context 'when nickname is empty' do
        it { is_expected.to be_invalid_on(:nickname).with(nil) }
      end

      context 'when nickname is over the max characters' do
        it { is_expected.to be_invalid_on(:nickname).with('a' * 21) }
      end
    end

    describe 'first_name' do
      context 'when first_name is empty' do
        it { is_expected.to be_invalid_on(:first_name).with(nil) }
      end

      context 'when first_name is over the max characters' do
        it { is_expected.to be_invalid_on(:first_name).with('a' * 31) }
      end
    end

    describe 'middle_name' do
      context 'when middle_name is over the max characters' do
        it { is_expected.to be_invalid_on(:middle_name).with('a' * 31) }
      end
    end

    describe 'last_name' do
      context 'when last_name is empty' do
        it { is_expected.to be_invalid_on(:last_name).with(nil) }
      end

      context 'when last_name is over the max characters' do
        it { is_expected.to be_invalid_on(:last_name).with('a' * 31) }
      end
    end

    # describe '#update a and file upload' do
    #   it 'can upload with update_attributes' do
    #     # sound モデルを更新してファイルをアップロードする
    #     user.update_attributes(avatar: fixture_file_upload('default_avatar.png', 'image/png'))
    #     user.reload
    #     # paperclipで生成されたファイル名を格納したカラムに値が入っていることを確認
    #     expect(user.avatar_file_name).not_to be_nil
    #  end
    # end

    describe 'avatar_file_name' do
      context 'when user create is insert default value' do
        it { expect(user.avatar_file_name).to eq('/images/default_avatar.png') }
      end
    end

  end
end
