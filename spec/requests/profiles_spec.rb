require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user1) { User.create(email:'test@example.com', password:'password2', password_confirmation:'password2') }
  let(:user2) { User.create(email: 'test2@example.com', password: 'testpassword2' ,password_confirmation: 'testpassword2') }
  let!(:profile1) { Profile.create(user_id: user1.id, username: 'testuser', food_types: 'fish', bio: "I'm not real...") }
  let!(:profile2) { Profile.create(user_id: user2.id, username: 'testuser2', food_types: 'landfish', bio: "I'm also not real...") }

  # INDEX
  it 'gets a list of Profiles' do
    # Create 2 new profiles in the Test Database (not the same one as development)

    # Make a request to the API
    get '/profiles'

    # Convert the response into a Ruby Hash
    json = JSON.parse(response.body)

    # Assure that we got a successful response
    expect(response).to be_successful

    # Assure that we got one result back as expected
    expect(json.length).to eq 2
  end

  # CREATE
  it 'creates a profile' do
    # The params we are going to send with the request
    profile_params = {
      profile: {
       user_id: user2.id, username: 'testuser3', food_types: 'test food', bio: 'test bio'
      }
    }

    # Send the request to the server
    post '/profiles', params: profile_params

    # Assure that we get a success back
    expect(response).to be_successful

    # Look up the profile we expect to be created in the Database
    new_profile = Profile.last

    # Assure that the created profile has the correct attributes
    expect(new_profile.username).to eq('testuser3')
  end

  # SHOW
  it 'gets a specified profile by their user ID' do
    # Create two profiles

    # Send the request to the server
    get "/profiles/#{profile2.user_id}"

    # Assure that we get a success back
    expect(response).to be_successful

    # Convert the response into a Ruby Hash
    json = JSON.parse(response.body)

    # Assure that we correct result back
    # expect(json).to include('username' => 'testuser2')
    expect(json['username']).to eq('testuser2')
  end

  # UPDATE
  it 'can make changes to an existing profile' do
    # we will apply these changes to the profile we create
    profile_params = {
      profile: {
       user_id: user2.id, username: 'testuser9000', food_types: 'update food', bio: 'update bio'
      }
    }

    # Apply changes
    patch "/profiles/#{profile2.id}", params: profile_params

    json = JSON.parse(response.body)
    expect(response).to have_http_status(200)

    # Make sure things were changed properly
    expect(json['username']).to eq('testuser9000')

  end

  # DESTROY
  it 'can destroy a specified profile' do

    # Create two profiles

    get "/profiles/#{profile1.id}"
    expect(response).to be_successful

    delete "/profiles/#{profile1.id}"

    # Assure an profile was deleted
    get '/profiles'
    json = JSON.parse(response.body)
    expect(json.length).to be 1

    # Assure the correct profile was deleted
    expect(json[0]).to include('username' => 'testuser2')
  end
end
