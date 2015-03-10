require 'spec_helper'

describe Sufia::Arkivo do
  describe 'Zotero integration' do
    # POST to http://arkivo.host/api/subscription
    # { url: “https://api.zotero.org/users/{zotero-id}/my-research/items”, key: “zotero-api-key”, plugins: [{name : “hydra”, parameters: { user_token: “unique-user-specific-token” }]}
    it 'initiates an OAuth connection to Zotero'
    it 'receives an access token from Zotero'
    # https://api.zotero.org/users/{zotero_id}/my-research/items
    it 'can successfully make requests to the Zotero endpoint'
    it 'returns JSON'
    # parse subscription URL out of JSON or location header, and store in ScholarSphere, for later possible invalidation via DELETE
    it 'includes a subscription URL'
    it 'fails with bad credentials'
    # DELETE /api/subscription/:id?invalidate-key=true
    it 'hits the Zotero API with HTTP DELETE if subscription request fails'
  end
end
