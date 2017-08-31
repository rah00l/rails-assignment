require 'rails_helper'

RSpec.describe 'Tenant', type: :request do
	# initialize test data
	let!(:tenant) { create_list(:tenant, 10) }
  let(:id) { tenant.first.id }
  let(:api_key) { tenant.first.api_key }

  # Test suite for GET /tenants/:id
  describe 'GET /tenants/:id' do
    before { get "/tenants/#{id}", nil, { 'X-TENANT-API-KEY' => api_key } }

    context 'when the record exists' do
      it 'returns the tenant' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tenant/)
      end
    end
  end
end
