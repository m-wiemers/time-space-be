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
    let!(:first_user) { FactoryBot.create(:user) }
    let!(:corporation) {FactoryBot.create(:corporation)}
    it 'create a new user' do
      expect {
       post '/api/v1/users', params: { user: FactoryBot.attributes_for(:user) }
      }.to change { User.count }.from(1).to(2)
      
      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body)
      expect(json_response).to include(
        'email' => User.last.email,
        'name' => User.last.name,
        'corporation_id' => nil
      )
    end

    it 'fails if email is not unique' do
      expect {
       post '/api/v1/users', params: { user: { name: Faker::Name::first_name, email: first_user.email } }
      }.to_not change { User.count }
      
      expect(response).to have_http_status(:unprocessable_content)
      expect(JSON.parse(response.body)['email']).to include('has already been taken')
    end

    it 'create a new user with corporation_id' do
      expect {
        post '/api/v1/users', params: { user: FactoryBot.attributes_for(:user).merge(corporation_id: corporation.id) }
      }.to change { User.count }.by(1)

      created_user = User.last

      expect(response).to have_http_status(:created)

      expect(JSON.parse(response.body)).to include(
        'email' => created_user.email,
        'name' => created_user.name,
        'corporation_id' => corporation.id
      )
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
