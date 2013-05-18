require 'spec_helper'

describe Measure do
  let(:city) { FactoryGirl.create(:city) }

  before { @measure = FactoryGirl.create(:measure, { city: city } ) }

  subject { @measure }

  it { should respond_to(:date) }
  it { should respond_to(:pm25) }

  it { should validate_presence_of(:date) }

  it { should validate_uniqueness_of(:date).scoped_to(:city_id) }

  it { should belong_to(:city) }
end
