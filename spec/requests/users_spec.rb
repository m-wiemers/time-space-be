require 'rails_helper'

describe 'Users API', type: :request do
  describe 'get Users' do
    let!(:users) { FactoryBot.create_list(:user, 2) }
    it 'returns all Users' do
      get '/api/v1/users'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /users' do
    let!(:fist_user) { FactoryBot.create(:user) }
    it 'create a new user' do
      expect {
       post '/api/v1/users', params: { user: FactoryBot.attributes_for(:user) }
      }.to change { User.count }.from(1).to(2)
      
      expect(response).to have_http_status(:created)
    end

    it 'fails if email is not unique' do
      expect {
       post '/api/v1/users', params: { user: { name: Faker::Name::first_name, email: fist_user.email } }
      }.to_not change { User.count }
      
      expect(response).to have_http_status(:unprocessable_content)
      expect(JSON.parse(response.body)['email']).to include('has already been taken')
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
