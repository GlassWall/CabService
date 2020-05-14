require 'rails_helper'

RSpec.describe Driver, type: :model do
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:phone_number) }
  it { should validate_uniqueness_of(:license_number) }
  it { should validate_uniqueness_of(:car_number) }
  it "should validate the size of phone_number to be 10 digits" do 
    expect { 
      create(:driver, phone_number: 9010023020323) 
    }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Phone number is the wrong length (should be 10 characters)")
  end
end
