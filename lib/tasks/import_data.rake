namespace :data do

  desc "Import data for PDL cities"
  task import_pdl: :environment do 
    Resque.enqueue(Pm25Importer)
  end

end

