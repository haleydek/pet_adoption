require 'pry'
require 'nokogiri'
require 'open-uri'

class PetAdoption::Scraper
  BASEPATH = 'https://www.animalhumanesociety.org'
  def get_page
    Nokogiri::HTML(open(BASEPATH + '/adoption'))
  end
  
  def scrape_species_paths
    species_paths = []
    self.get_page.css("#block-animaltype div div li.facet-item").each do |one_species|
      path = BASEPATH + one_species.css("a").attr("href").text
      species_paths << path
    end
    species_paths
  end
  
  def scrape_species
    species = []
    self.get_page.css("#block-animaltype div div li.facet-item").each do |one_species|
      pet_species = one_species.css("a .facet-item__value").text
      species << pet_species
    end
    species
  end
  
  def scrape_pets_by_species
    #accepts user input of species. Retrieves corresponding species url and scrapes list of pets
    #variable should be a species path, not a hard-coded URL
    page = Nokogiri::HTML(open('https://www.animalhumanesociety.org/adoption?f%5B0%5D=animal_type%3ASmall%26Furry'))
    page.css("div.views-row").each do |pet|
      pet_name = pet.css(".field--name-name a").text
      pet_breed = pet.css(".field field--breed").text
      pet_url = BASEPATH + pet.css(".field--name-name a").attr("href").text
    end
  end
  
  
end