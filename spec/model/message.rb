require 'rails_helper'

RSpec.describe Message do
  subject { build(:message) }
  describe 'validations' do
    describe 'text' do
      context 'when it is empty' do
        it { is_expected.to be_invalid_on(:text).with('') }
      end

      context 'when it is nil' do
        it { is_expected.to be_invalid_on(:text).with(nil) }
      end

      context 'when it is over the max charcters' do
        it { is_expected.to be_invalid_on(:text).with('a' * 4001) }
      end
    end
  end
end
