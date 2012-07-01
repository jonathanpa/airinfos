require 'spec_helper'

describe City do

  before { @city = FactoryGirl.create(:city) }

  subject { @city }

  it { should.respond_to?(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it { should have_many(:measures) }

  describe "Measures associations" do

    let(:measure1_attr) { { date: DateTime.now, pm25: 10 } }
    let(:measure2_attr) { { date: DateTime.now + 1.day, pm25: 5 } }

    it "should record measures for a city" do
      measure1 = @city.measures.create(measure1_attr)
      measure2 = @city.measures.create(measure2_attr)

      @city.measures.count.should == 2
      @city.measures.should include(measure1, measure2)
    end


    it "should delete measures associations" do
      measure = FactoryGirl.create(:measure, { city: @city })
      @city.destroy

      lambda do
        Measure.find(measure.id)
      end.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
