namespace :data do

  desc "Import data for PDL cities"
  task import_pdl: :environment do 
    Pm25Importer.perform
  end

end

