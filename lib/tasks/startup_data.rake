namespace :db do

  desc "Generate the cities for PDL"
  task generate_cities_pdl: :environment do
    City.destroy_all

    cities = { angers: "Angers", lemans: "Le Mans", nantes: "Nantes", saintnazaire: "Saint-Nazaire" }

    cities.each do |key, cityname|
      City.create!( { code: key.to_s, name: cityname } )
    end
  end
end
