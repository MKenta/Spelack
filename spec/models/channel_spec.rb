require 'rails_helper'

RSpec.describe Channel do
  subject { build(:channel) }
  describe 'validations' do
    context 'when name is empty' do
      it { is_expected.to be_invalid_on(:name).with(nil) }
    end

    context 'when name is over the max charcters' do
      it { is_expected.to be_invalid_on(:name).with('a' * 51) }
    end

    context 'when name is contains uppercase letters' do
      it { is_expected.to be_invalid_on(:name).with(FFaker::Name.last_name) }
    end

    context 'When name is included double-byte characters' do
      it { is_expected.to be_invalid_on(:name).with(FFaker::JobJA.title) }
    end

    context 'When name is contains an illegal symbol' do
      ['?', '%', '$', '*', '<', '>', '#', '(', ')', '|', '¥', ';', '&', '@'].each do |symbol|
        it { is_expected.to be_invalid_on(:name).with(FFaker::BaconIpsum.characters(10) + symbol) }
      end
    end

    context 'When name is already registered' do
      before do
        channel = create(:channel)
        @name = channel.name
      end
      it { is_expected.to be_invalid_on(:name).with(@name) }
    end

    describe 'status' do
      context 'when it is empty' do
        it { is_expected.to be_invalid_on(:status).with(nil) }
      end
    end

    describe 'description' do
      context 'when it is over the max charcters' do
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
