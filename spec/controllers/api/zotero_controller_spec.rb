require 'spec_helper'

describe API::ZoteroController, type: :controller do
  let(:user) { FactoryGirl.find_or_create(:jill) }

  context 'with an HTTP GET to /api/zotero' do
    context 'with an unauthenticated client' do
      it 'errors out'
    end

    context 'with a non-local request' do
      it 'errors out'
    end

    context 'with an invalid key/secret combo' do
      it 'errors out'
    end

    describe '#callback_url' do
      context 'when in the dev environment' do
        it 'has the expected callback URL'
      end

      context 'when in the production environment' do
        it 'has the expected callback URL'
      end
    end

    it 'gets a request token'
    it 'stuffs a request token in the session'
    it 'stores a request token in the user instance'
    it 'redirects to the authorize_url'
  end

  context 'with an HTTP POST/GET to /api/zotero/callback' do
    context 'with a request not from zotero.org (e.g., localhost)' do
      it 'errors out'
    end

    it 'finds a matching request token'
    it 'gets an access token'
    it 'extracts a userID from the access token'
    it 'stores the userID in the user instance'
    it 'invalidates the no-longer-useful API key'
  end
end
