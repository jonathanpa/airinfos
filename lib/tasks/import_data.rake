namespace :data do

  desc "Import data for PDL cities"
  task import_pdl: :environment do 
    if Rails.env == 'development'
      Resque.enqueue(Pm25Importer)
    else
      Pm25Importer.perform
    end
  end

end

