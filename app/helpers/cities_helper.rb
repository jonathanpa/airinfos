#encoding: utf-8
module CitiesHelper

  def level_class(pm25)
    case pm25
    when 0..15    then "success"
    when 16..40   then "info"
    when 41..65   then "warning"
    when 66..150  then "important"
    when 151..300 then "important"
    when 301..500 then "inverse"
    end
  end
  
  def level_message(pm25)
    case pm25
    when 0..15    then "Bon"
    when 16..40   then "Modéré"
    when 41..65   then "Mauvais (personnes à risques)"
    when 66..150  then "Mauvais"
    when 151..300 then "Très mauvais"
    when 301..500 then "Dangereux"
    end
  end

end
