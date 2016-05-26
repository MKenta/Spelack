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

      context 'When nickname is already registered' do
        before do
          user = create(:user)
          @nickname = user.nickname
        end
        it { is_expected.to be_invalid_on(:nickname).with(@nickname) }
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
  end
end
