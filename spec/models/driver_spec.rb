require 'rails_helper'

RSpec.describe Driver, type: :model do
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:phone_number)}
  it { should validate_presence_of(:license_number)}
  it { should validate_presence_of(:car_number)}

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:phone_number) }
  it { should validate_uniqueness_of(:license_number) }
  it { should validate_uniqueness_of(:car_number) }
  it "should validate the size of phone_number to be 10 digits" do 
    expect { 
      create(:driver, phone_number: 9010023020323) 
    }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Phone number is the wrong length (should be 10 characters)")
  end
  it "should validate latitude longitude if update_location is set as true" do 
    expect { 
      a = create(:driver) 
      a.update_location = true
      a.save!
    }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Latitude can't be blank, Longitude can't be blank")
  end
end
