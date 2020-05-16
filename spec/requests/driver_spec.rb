# spec/requests/driver_spec.rb
require 'rails_helper'

RSpec.describe 'Driver API', type: :request do
  # initialize test data 
  let!(:drivers) { create_list(:driver, 10, latitude: 100, longitude: 100) }
  
  # Test suite for POST /api/v1/passenger/available_cabs/
  describe 'POST /api/v1/passenger/available_cabs/' do
    # valid payload
    let(:valid_attributes) {
      {
        "latitude": 100,
          "longitude": 100
      }
    }
    
    context 'when the request is valid' do
      before { post '/api/v1/passenger/available_cabs/', params: valid_attributes }

      it 'should respond with 10 cabs' do
        expect(json["available_cabs"].count).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context "when the request is valid but there are no cabs" do
      before { post '/api/v1/passenger/available_cabs/', params: {latitude: 101, longitude: 101} }
      it 'should respond with 10 cabs' do
        expect(json["message"]).to eq("No cabs available!")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the request is invalid' do
      before { post '/api/v1/passenger/available_cabs/', params: { } }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(json['reason'])
          .to eq("Latitude and Longitude must be present in request")
      end
    end
  end

  # Test suite for POST /api/v1/driver/register
  describe 'POST /api/v1/driver/register' do
    # valid payload
    let(:valid_attributes) {
      {
        "name": "Nilesh Agarwal",
        "email": "nick.aggarwal@gmail.com",
        "phone_number": 9876543201,
        "license_number": "UP20141234567911",
        "car_number": "KA03JJ1234"
      }
    }

    context 'when the request is valid' do
      before { post '/api/v1/driver/register', params: valid_attributes }

      it 'registers a driver' do
        expect(json['name']).to eq('Nilesh Agarwal')
        expect(json['email']).to eq('nick.aggarwal@gmail.com')
        expect(json['phone_number']).to eq(9876543201)
        expect(json['license_number']).to eq('UP20141234567911')
        expect(json['car_number']).to eq('KA03JJ1234')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/driver/register', params: { } }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(json['reason'])
          .to eq("Validation failed: Name can't be blank, Email can't be blank, Phone number can't be blank, Phone number is the wrong length (should be 10 characters), License number can't be blank, Car number can't be blank")
      end
    end
  end

  # Test suite for post /api/v1/driver/:id/sendLocation/
  describe 'POST /api/v1/driver/:id/sendLocation/' do
    let(:valid_attributes) { { latitude: 71.23232, longitude: 1.23232 } }
    let(:invalid_attributes) { { latitude: nil, longitude: 1.23232 } }

    context 'when the record exists' do
      before { post "/api/v1/driver/9/sendLocation/", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 202' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when the record does not exist' do
      before { post "/api/v1/driver/19/sendLocation/", params: invalid_attributes }

      it 'updates the record' do
        expect(json).to eq({"status"=>"failure", "reason"=>"Couldn't find Driver with 'id'=19"})
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when we pass invalid_attributes' do
      before { post "/api/v1/driver/9/sendLocation/", params: invalid_attributes }

      it 'updates the record' do
        expect(json).to eq({"status"=>"failure", "reason"=>"Validation failed: Latitude can't be blank"})
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end