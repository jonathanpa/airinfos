class Pm25Importer

  def self.perform
    mapping = { angers: [2], lemans: [3], nantes: [4, 5], saintnazaire: [6] }
    
    now = DateTime.now.in_time_zone('Paris')
    time_measure = DateTime.civil(now.year, now.month, now.day, now.hour)
    yesterday = time_measure - 1.day

    xls_source = "http://www.airpl.org/mesuresindices/mesurexcel?polluant=P2&site[]=_BART&site[]=_SOUR&site[]=_BOUT&site[]=_VHUG&site[]=_BLUM&periode=_2&j=#{yesterday.day}&m=#{yesterday.month}&a=#{yesterday.year}&=excel" << ".xls"

    pdl_measures = Excel.new(xls_source)
    pdl_measures.default_sheet = pdl_measures.sheets.first

    mapping.each do |code, columns|
      import_data_from_city(code, time_measure, pdl_measures, columns)
    end

    if Rails.env.development?
      display_measures(mapping.keys)
    end
  end

  private

  def self.import_data_from_city(city_code, time_measure, xls, columns)
    end_row = 101 + 4 * time_measure.hour
    start_row = end_row - 4

    city = City.find_by_code(city_code.to_s)
    city_pm2s = []

    columns.each do |c|
      pm2_total = 0
      pm2_count = 0

      (start_row..end_row).each do |row|
        unless xls.cell(row, c).blank?
          pm2_total += xls.cell(row, c)
          pm2_count += 1
        end
      end

      pm2_total == 0 ? city_pm2s.push(0) : city_pm2s.push(pm2_total / pm2_count)
    end

    city_pm2s.sort!.reverse!
 
    city.measures.create!( { date: time_measure, pm25: city_pm2s.first } )
  end

  def self.display_measures(city_codes)
    city_codes.each do |code|
      measure = City.find_by_code(code.to_s).measures.last
      puts "#{code}\t#{measure.inspect}"
    end
  end
end
