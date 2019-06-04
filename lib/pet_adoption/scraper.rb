require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
  def self.scrape_index_page
    index_page = Nokogiri::HTML(open('http://www.pawschicago.org/our-work/pet-adoption/pets-available/'))
    pets = []
    pet_types = ["cats", "dogs"]
    pet_types.each do |type|
      index_page.css(".col-md-10 col-md-offset-1 col-xs-12 events-adopt-cntr").each do |pet_block|
        pet.css("div.adopt-pet a").each do |pet|
          pet_profile_link = "#{pet.attr("href")}"
          pet_name = pet.css("h3").text
          pet_location = pet.css("h6").text
          pet_type = "cats"
          pets << { name: pet_name, location: pet_location, type: pet_type, profile_link: pet_profile_link }
        end
      end
    end
    pets
  end
end