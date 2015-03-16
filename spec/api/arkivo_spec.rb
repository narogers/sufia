require 'spec_helper'

describe Sufia::Arkivo do
  describe 'Subscription API' do
    # POST to http://arkivo.host/api/subscription
    # { url: “https://api.zotero.org/users/{zotero-id}/my-research/items”, key: “zotero-api-key”, plugins: [{name : “hydra”, parameters: { user_token: “unique-user-specific-token” }]}
    # https://api.zotero.org/users/{zotero_id}/my-research/items
    it 'can successfully make requests to the Arkivo endpoint'
    it 'gets JSON'
    # parse subscription URL out of JSON or location header, and store in ScholarSphere, for later possible invalidation via DELETE
    it 'includes a subscription URL'
    it 'fails with bad credentials'
    # DELETE /api/subscription/:id?invalidate-key=true
    it 'hits the subscription API with HTTP DELETE if request fails'
  end
end
