require 'spec_helper'

describe Sufia::Arkivo do
  it { is_expected.to respond_to(:config) }

  describe 'configuration' do
    subject { Sufia::Arkivo.config }

    let(:client_key) { 'abc123' }
    let(:client_secret) { '789xyz' }

    before do
      stub_const('ENV', {
          'ZOTERO_CLIENT_KEY' => client_key,
          'ZOTERO_CLIENT_SECRET' => client_secret
        })
    end

    it 'has a client key' do
      expect(subject['client_key']).to eq(client_key)
    end

    it 'has a client secret' do
      expect(subject['client_secret']).to eq(client_secret)
    end
  end
end
