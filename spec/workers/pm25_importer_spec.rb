require 'spec_helper'
require 'rake'

describe Pm25Importer do
  let(:my_date) { DateTime.civil(2012, 12, 30, 21).
    change({ offset: Rational(1, 24) }) }

  let!(:my_xls_source) { Excel.new('spec/fixtures/measures.xls') }
  let!(:my_xls_source_missing) { Excel.new('spec/fixtures/measures_missing.xls') }
  let!(:my_xls_source_missing_all) { Excel.new('spec/fixtures/measures_missing_all.xls') }

  before do
    Rake::Task.clear
    Airinfos::Application.load_tasks
    Rake::Task['db:generate_cities_pdl'].invoke

    DateTime.stub(:now).and_return(my_date)
  end

  context 'with all data measures present in xls' do
    before do
      Excel.stub(:new).and_return(my_xls_source)
      Pm25Importer.perform
    end

    it 'should calculate the average pm25' do
      City.find_by_code('angers').measures.first.pm25.should == 13
      City.find_by_code('lemans').measures.first.pm25.should == 7

      # With Nantes, we select the highest measure between the
      # both station, here it's the second one.
      City.find_by_code('nantes').measures.first.pm25.should == 14

      City.find_by_code('saintnazaire').measures.first.pm25.should == 6
    end
  end

  context 'with missing data measures in xls' do
    before do
      Excel.stub(:new).and_return(my_xls_source_missing)
      Pm25Importer.perform
    end
    
    it 'should calculate the average pm25' do
      City.find_by_code('angers').measures.first.pm25.should == 7
      City.find_by_code('lemans').measures.first.pm25.should == 4

      # With Nantes, we select the highest measure between the
      # both station, here it's the second one.
      City.find_by_code('nantes').measures.first.pm25.should == 8

      City.find_by_code('saintnazaire').measures.first.pm25.should == 5
    end
  end

  context 'with all data measures missing in xls' do
    before do
      Excel.stub(:new).and_return(my_xls_source_missing_all)
      Pm25Importer.perform
    end
    
    it 'should calculate the average pm25' do
      City.find_by_code('angers').measures.first.pm25.should == 0
      City.find_by_code('lemans').measures.first.pm25.should == 0

      # With Nantes, we select the highest measure between the
      # both station, here it's the second one.
      City.find_by_code('nantes').measures.first.pm25.should == 0

      City.find_by_code('saintnazaire').measures.first.pm25.should == 0
    end
  end
end

