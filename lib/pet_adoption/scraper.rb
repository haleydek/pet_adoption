require 'pry'
require 'nokogiri'
require 'open-uri'

class PetAdoption::Scraper
  BASEPATH = 'https://www.animalhumanesociety.org'
  def get_page
    Nokogiri::HTML(open(BASEPATH + '/adoption'))
  end
  
  def scrape_pet_type_paths
    pet_type_paths = []
    self.get_page.css("#block-animaltype div div li.facet-item").each do |pet_type|
      pet_type_url = pet_type.css("a").attr("href").text
      pet_type_paths << (BASEPATH + pet_type_url)
    end
    pet_type_paths
  end
  
  def scrape_pet_types
    pet_types = []
    self.get_page.css("#block-animaltype div div li.facet-item").each do |pet_type|
      pet_type = pet_type.css("a .facet-item__value").text
      pet_types << pet_type
    end
    pet_types
  end
  
  def scrape_pets_by_type
    #accepts user input of pet type. Retrieves corresponding pet type url and scrapes list of pets
    page = Nokogiri::HTML(open('https://www.animalhumanesociety.org/adoption?f%5B0%5D=animal_type%3ASmall%26Furry'))
    page.css("div.views-row").each do |pet|
      pet
    end
  end
  
  
end