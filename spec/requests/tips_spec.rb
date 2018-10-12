require 'rails_helper'

RSpec.describe "Tips", type: :request do
  before(:each) do
    @user1 = User.create(email: 'test@example.com', password: 'testpassword', password_confirmation: 'testpassword')
  end

  # INDEX
  it 'gets a list of Tips' do
    # Create a new tip in the Test Database (not the same one as development)
    Tip.create(user_id: @user1.id, restaurant: 'LEARN Acadameal', food_types: 'codefish', description: "Although it may look weird at first glance, Chef Alyssa's fried unicorn actually tastes pretty good; they have a limited supply every day so if you go later in the day you gotta Hope they haven't run out. Anything made by Chef Jez is a Go! All of Chef Damon's food tastes like Lemmons...", image: "learn.jpg")
    Tip.create(user_id: @user1.id, restaurant: "Ralph's", food_types: 'various', description: "The pizza is dank and doesn't taste burnt", image: "ralphs.jpg")

    # Make a request to the API
    get '/tips'

    # Convert the response into a Ruby Hash
    json = JSON.parse(response.body)

    # Assure that we got a successful response
    expect(response).to be_successful

    # Assure that we got one result back as expected
    expect(json.length).to eq 2
  end

  # CREATE
  it 'creates a tip' do
    # The params we are going to send with the request
    tip_params = {
     tip: {
       user_id: @user1.id, restaurant: "Ralph's", food_types: 'various', description: "The pizza is dank and doesn't taste burnt", image: "img.jpg"
     }
    }

    # Send the request to the server
    post '/tips', params: tip_params

    # Assure that we get a success back
    expect(response).to be_successful

    # Look up the tip we expect to be created in the Database
    new_tip = Tip.first

    # Assure that the created tip has the correct attributes
    expect(new_tip.restaurant).to eq("Ralph's")
  end

  # SHOW
  it 'gets a specified tip' do
    # Create two tips
    tip1 = Tip.create(user_id: @user1.id, restaurant: 'LEARN Acadameal', food_types: 'codefish', description: "Although it may look weird at first glance, Chef Alyssa's fried unicorn actually tastes pretty good; they have a limited supply every day so if you go later in the day you gotta Hope they haven't run out. Anything made by Chef Jez is a Go! All of Chef Damon's food tastes like Lemmons...", image: "learn.jpg")
    tip2 = Tip.create(user_id: @user1.id, restaurant: "Ralph's", food_types: 'various', description: "The pizza is dank and doesn't taste burnt", image: "ralphs.jpg")

    # Send the request to the server
    get "/tips/#{tip2.id}"

    # Assure that we get a success back
    expect(response).to be_successful

    # Convert the response into a Ruby Hash
    json = JSON.parse(response.body)

    # Assure that we correct result back
    # expect(json).to include('username' => 'testuser2')
    expect(json['restaurant']).to eq("Ralph's")
  end

  # UPDATE
  it 'can make changes to an existing tip' do
    # we will apply these changes to the tip we create
    tip_params = {
     tip: {
       user_id: @user1.id, restaurant: "Ralph's", food_types: 'various', description: "The pizza is dank and doesn't taste burnt", image: "ralphs.jpg"
     }
    }

    # create tip
    update_tip = Tip.create( user_id: @user1.id, restaurant: 'yuh', food_types: 'yuh', description: 'yuh', image: 'img.jpg')

    # Apply changes
    patch "/tips/#{update_tip.id}", params: tip_params

    json = JSON.parse(response.body)
    expect(response).to have_http_status(200)

    # Make sure things were changed properly
    expect(json['restaurant']).to eq("Ralph's")

  end

  # DESTROY
  it 'can destroy a specified tip' do
    # Create two tips
    tip1 = Tip.create(user_id: @user1.id, restaurant: 'LEARN Acadameal', food_types: 'codefish', description: "Although it may look weird at first glance, Chef Alyssa's fried unicorn actually tastes pretty good; they have a limited supply every day so if you go later in the day you gotta Hope they haven't run out. Anything made by Chef Jez is a Go! All of Chef Damon's food tastes like Lemmons...", image: 'learn.jpg')
    tip2 = Tip.create(user_id: @user1.id, restaurant: "Ralph's", food_types: 'various', description: "The pizza is dank and doesn't taste burnt", image: 'ralphs.jpg')

    get "/tips/#{tip1.id}"
    expect(response).to be_successful

    delete "/tips/#{tip1.id}"

    # Assure an tip was deleted
    get '/tips'
    json = JSON.parse(response.body)
    expect(json.length).to be 1

    # Assure the correct tip was deleted
    expect(json[0]).to include('restaurant' => "Ralph's")
  end
end
