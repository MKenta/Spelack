require 'rails_helper'

RSpec.describe Channel do
  subject { build(:channel) }
  describe 'validations' do
    describe 'name' do
      context 'when it is empty' do
        it { is_expected.to be_invalid_on(:name).with(nil) }
      end

      context 'when it is over' do
        it { is_expected.to be_invalid_on(:name).with('a' * 51) }
      end
    end

    describe 'status' do
      context 'when it is empty' do
        it { is_expected.to be_invalid_on(:status).with(nil) }
      end
    end

    describe 'description' do
      context 'when it is over' do
        it { is_expected.to be_invalid_on(:description).with('a' * 1001) }
      end
    end

    describe 'author_id' do
      context 'when it is empty' do
        it { is_expected.to be_invalid_on(:author_id).with(nil) }
      end
    end
  end
end
