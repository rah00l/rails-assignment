require 'rails_helper'

RSpec.describe 'Question', type: :request do
	# initialize test data
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let(:id) { question.id }

  let(:tenant) { create(:tenant) }
  let(:api_key) { tenant.api_key }

  # Test suite for GET /questions
  describe 'GET /questions' do
    before { get '/questions', nil, { 'X-TENANT-API-KEY' => api_key } }

    it 'returns questions' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /questions?query=''
  describe 'GET /questions' do
    before { get "/questions?query=#{question.title}",nil , { 'X-TENANT-API-KEY' => api_key } }

    it 'returns questions' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /questions/:id
  describe 'GET /questions/:id' do
    before { get "/questions/#{id}", nil, { 'X-TENANT-API-KEY' => api_key } }

    context 'when the record exists' do
      it 'returns the question' do
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
        expect(response.body).to match(/Couldn't find Question/)
      end
    end
  end
end
