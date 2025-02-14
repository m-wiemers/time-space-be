require 'rails_helper'

describe 'Users API', type: :request do
  describe 'get Users' do
    it 'returns all Users' do
      FactoryBot.create_list(:user, 2)
      get '/api/v1/users'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /users' do
    it 'create a new user' do
      expect {
       post '/api/v1/users', params: { user: { name: Faker::Name::first_name, email: Faker::Internet::email } }
      }.to change { User.count }.from(0).to(1)
      
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /users/:id' do
    let!(:user) { FactoryBot.create(:user) }

    it 'delete an user' do
      expect {
       delete "/api/v1/users/#{user.id}"
      }.to change { User.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
