require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  # INDEX
  it 'gets a list of Profiles' do
    user1 = User.create(email: 'test@example.com', password: 'testpassword')
    user2 = User.create(email: 'test2@example.com', password: 'testpassword2')
    # Create a new profile in the Test Database (not the same one as development)
    Profile.create(user_id: user1.id, username: 'testuser', food_types: 'fish', bio: "I'm not real...")
    Profile.create(user_id: user2.id, username: 'testuser2', food_types: 'landfish', bio: "I'm also not real...")

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
    user1 = User.create(email: 'test@example.com', password: 'testpassword')
    # The params we are going to send with the request
    profile_params = {
     profile: {
       user_id: user1.id, username: 'testuser', food_types: 'test food', bio: 'test bio'
     }
    }

    # Send the request to the server
    post '/profiles', params: profile_params

    # Assure that we get a success back
    expect(response).to be_successful

    # Look up the profile we expect to be created in the Database
    new_profile = Profile.first

    # Assure that the created profile has the correct attributes
    expect(new_profile.username).to eq('testuser')
  end

  # SHOW
  it 'gets a specified profile' do
    user1 = User.create(email: 'test@example.com', password: 'password2')
    # Create two profiles
    profile1 = Profile.create(user_id: user1.id, username: 'testuser1', food_types: 'test food', bio: 'test bio')

    profile2 = Profile.create(user_id: user1.id, username: 'testuser2', food_types: 'test food', bio: 'test bio')

    # Send the request to the server
    get "/profiles/#{profile2.id}"

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
    user1 = User.create(email:'test@example.com', password:'password2')
    # we will apply these changes to the profile we create
    profile_params = {
     profile: {
       user_id: user1.id, username: 'testuser', food_types: 'test food', bio: 'test bio'
     }
    }

    # create profile
    update_profile = Profile.create( user_id: user1.id, username: 'yuh', food_types: 'yuh', bio: 'yuh')

    # Apply changes
    patch "/profiles/#{update_profile.id}", params: profile_params

    json = JSON.parse(response.body)
    expect(response).to have_http_status(200)

    # Make sure things were changed properly
    expect(json['username']).to eq('testuser')

  end

  # DESTROY
  it 'can destroy a specified profile' do
    user1 = User.create(email:'test@example.com', password:'password2')
    # Create two profiles
    profile1 = Profile.create(user_id: user1.id, username: 'testuser1', food_types: 'test food', bio: 'test bio')

    profile2 = Profile.create(user_id: user1.id, username: 'testuser2', food_types: 'test food', bio: 'test bio')

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
