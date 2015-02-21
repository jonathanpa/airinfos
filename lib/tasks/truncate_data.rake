namespace :data do 
  desc "Truncate measures table when number of rows is near 10 000."
  task truncate: :environment do
    if Measure.count > 9500
      Rails.logger.info "Truncate 9500 lines of measures table."
      Measure.order("created_at").limit(9500).destroy_all
    end
  end
end

