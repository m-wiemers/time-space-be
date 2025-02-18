require 'rails_helper'

RSpec.describe "Corporations API", type: :request do
  describe 'get Coporations' do
    let!(:corporations) { FactoryBot.create_list(:corporation, 2) }
    it 'returns all Corporations' do
      get '/api/v1/corporations'

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
    end
  end

  describe 'POST Corporation' do
    let!(:corporation) { FactoryBot.create(:corporation) }
    it 'create a new corporation' do
      expect {
       post '/api/v1/corporations', params: { corporation: FactoryBot.attributes_for(:corporation) }
      }.to change { Corporation.count }.from(1).to(2)
      
      expect(response).to have_http_status(:created)

      expect(response_body).to include(
        'name' => Corporation.last.name,
        'location' => Corporation.last.location,
      )
    end
  end

  describe 'DELETE /corporations/:id' do
    let!(:corporation) { FactoryBot.create(:corporation) }
    it 'delete a corporations' do
      expect {
       delete "/api/v1/corporations/#{corporation.id}"
      }.to change { Corporation.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
