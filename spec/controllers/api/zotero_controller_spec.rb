require 'spec_helper'

describe API::ZoteroController, type: :controller do
  let(:user) { FactoryGirl.find_or_create(:jill) }

  context 'with an HTTP POST to /api/zotero' do
    context 'without an item' do
      before do
        post :create, format: :json
      end

      subject { response }

      it { is_expected.to have_http_status(400) }

      it 'describes the error' do
        expect(subject.body).to include('no item parameter')
      end
    end

    context 'with an invalid item' do
      before do
        post :create, format: :json, item: item
      end

      let(:item) { { foo: 'bar' }.to_json }

      subject { response }

      it { is_expected.to have_http_status(400) }

      it 'describes the error' do
        expect(subject.body).to include('The property \'#/\' did not contain a required property of \'token\'')
      end
    end

    context 'with a valid item and matching token' do
      before do
        expect { post :create, format: :json, item: item }.to change { GenericFile.count }.by(1)
      end

      let(:deposited_file) { GenericFile.where(label: item['file']['filename']).take }
      let(:token) { user.arkivo_token }
      let(:item) { FactoryGirl.json(:post_item, token: token) }
      let(:item_hash) { JSON.parse(item) }

      subject { response }

      it { is_expected.to be_success }

      it 'responds with HTTP 201' do
        expect(response.status).to eq 201
      end

      it 'provides a URI in the Location header' do
        expect(response.headers['Location']).to match %r{/api/items/.{9}}
      end

      it 'creates a new item via POST' do
        expect(deposited_file).not_to be_nil
      end

      it 'writes metadata to allow flagging Arkivo-deposited items' do
        expect(deposited_file.arkivo_checksum).to eq item_hash['file']['md5']
      end

      it 'writes content' do
        expect(deposited_file.content.content).to eq "arkivo\n"
      end

      it 'batch applies specified metadata' do
        expect(deposited_file.resource_type).to eq [item_hash['metadata']['resourceType']]
        expect(deposited_file.title).to eq [item_hash['metadata']['title']]
        expect(deposited_file.description).to eq [item_hash['metadata']['description']]
        expect(deposited_file.publisher).to eq [item_hash['metadata']['publisher']]
        expect(deposited_file.date_created).to eq [item_hash['metadata']['dateCreated']]
        expect(deposited_file.based_near).to eq [item_hash['metadata']['basedNear']]
        expect(deposited_file.identifier).to eq [item_hash['metadata']['identifier']]
        expect(deposited_file.related_url).to eq [item_hash['metadata']['url']]
        expect(deposited_file.language).to eq [item_hash['metadata']['language']]
        expect(deposited_file.rights).to eq [item_hash['metadata']['rights']]
        expect(deposited_file.tag).to eq item_hash['metadata']['tags']
        expect(deposited_file.creator).to eq ['John Doe', 'Babs McGee']
        expect(deposited_file.contributor).to eq ['Rafael Nadal', 'Jane Doeski']
      end
    end

    context 'with a valid item and unfamiliar token' do
      before do
        post :create, format: :json, item: item
      end

      let(:token) { 'unfamiliar_token' }
      let(:item) { FactoryGirl.json(:post_item, token: token) }

      subject { response }

      it { is_expected.not_to be_success }

      it 'responds with HTTP 401' do
        expect(subject.status).to eq 401
      end

      it 'provides a reason for refusing to act' do
        expect(subject.body).to include("invalid user token: #{token}")
      end
    end
  end

  context 'with an HTTP POST/GET to /api/zotero/callback' do
    context 'without an item' do
      before do
        post :create, format: :json
      end

      subject { response }

      it { is_expected.to have_http_status(400) }

      it 'describes the error' do
        expect(subject.body).to include('no item parameter')
      end
    end

    context 'with an invalid item' do
      before do
        post :create, format: :json, item: item
      end

      let(:item) { { foo: 'bar' }.to_json }

      subject { response }

      it { is_expected.to have_http_status(400) }

      it 'describes the error' do
        expect(subject.body).to include('The property \'#/\' did not contain a required property of \'token\'')
      end
    end

    context 'with a valid item and matching token' do
      before do
        expect { post :create, format: :json, item: item }.to change { GenericFile.count }.by(1)
      end

      let(:deposited_file) { GenericFile.where(label: item['file']['filename']).take }
      let(:token) { user.arkivo_token }
      let(:item) { FactoryGirl.json(:post_item, token: token) }
      let(:item_hash) { JSON.parse(item) }

      subject { response }

      it { is_expected.to be_success }

      it 'responds with HTTP 201' do
        expect(response.status).to eq 201
      end

      it 'provides a URI in the Location header' do
        expect(response.headers['Location']).to match %r{/api/items/.{9}}
      end

      it 'creates a new item via POST' do
        expect(deposited_file).not_to be_nil
      end

      it 'writes metadata to allow flagging Arkivo-deposited items' do
        expect(deposited_file.arkivo_checksum).to eq item_hash['file']['md5']
      end

      it 'writes content' do
        expect(deposited_file.content.content).to eq "arkivo\n"
      end

      it 'batch applies specified metadata' do
        expect(deposited_file.resource_type).to eq [item_hash['metadata']['resourceType']]
        expect(deposited_file.title).to eq [item_hash['metadata']['title']]
        expect(deposited_file.description).to eq [item_hash['metadata']['description']]
        expect(deposited_file.publisher).to eq [item_hash['metadata']['publisher']]
        expect(deposited_file.date_created).to eq [item_hash['metadata']['dateCreated']]
        expect(deposited_file.based_near).to eq [item_hash['metadata']['basedNear']]
        expect(deposited_file.identifier).to eq [item_hash['metadata']['identifier']]
        expect(deposited_file.related_url).to eq [item_hash['metadata']['url']]
        expect(deposited_file.language).to eq [item_hash['metadata']['language']]
        expect(deposited_file.rights).to eq [item_hash['metadata']['rights']]
        expect(deposited_file.tag).to eq item_hash['metadata']['tags']
        expect(deposited_file.creator).to eq ['John Doe', 'Babs McGee']
        expect(deposited_file.contributor).to eq ['Rafael Nadal', 'Jane Doeski']
      end
    end

    context 'with a valid item and unfamiliar token' do
      before do
        post :create, format: :json, item: item
      end

      let(:token) { 'unfamiliar_token' }
      let(:item) { FactoryGirl.json(:post_item, token: token) }

      subject { response }

      it { is_expected.not_to be_success }

      it 'responds with HTTP 401' do
        expect(subject.status).to eq 401
      end

      it 'provides a reason for refusing to act' do
        expect(subject.body).to include("invalid user token: #{token}")
      end
    end
  end
end
