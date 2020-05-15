require 'rails_helper'
RSpec::describe Calculator::DerivedPoints do
  it 'should calculate point given lat lon range and bearings' do
    calculator = Calculator::DerivedPoints.new(lat: 12.972442, long: 77.580643, range: 1.1, bearing: 90)
    expect(calculator.calculate_derived_position.map do |x| x.to_s end).to eq(["12.972441999999804", "77.58065315162592"])
  end
end
