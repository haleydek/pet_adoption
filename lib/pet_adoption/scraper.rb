require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  BASE_PATH = htpps://www.pawschicago.org/
  
  def self.scrape_index_page(BASE_PATH)
    index_page = Nokogiri::HTML(open(BASE_PATH + "our-work/pet-adoption/pets-available/"))
    pets = []
    pet_classes = ["cats", "dogs"]
    pet_classes.each do |class|
      index_page.css("div.pets-placeholder article.#{class}").each do |pet_block|
        pet.css("div.adopt-pet a").each do |pet|
          pet_profile_link = "#{pet.attr("href")}"
          pet_name = pet.css("h3").text
          pet_location = pet.css("h6").text
          pet_type = "#{class}"
          pets << { name: pet_name, location: pet_location, type: pet_type, profile_link: pet_profile_link }
          binding.pry
        end
      end
    end

        
    
    pets
  end
end