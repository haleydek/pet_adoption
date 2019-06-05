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
    #Need a method that accepts user input of species. Retrieves corresponding species url
    #accepts argument of species url
    #scrapes list of pets
    page = Nokogiri::HTML(open('https://www.animalhumanesociety.org/adoption?f%5B0%5D=animal_type%3ACat'))
    page.css("div.views-row").each do |pet|
      name = pet.css("div.field--name-name a").text
      breed = pet.css("div.field.field--breed").text.strip
      url = BASEPATH + pet.css("div.field--name-name a").attr("href").text
      shelter = pet.css("div.field.field--name-field-location.field--type-entity-reference.field--label-hidden.field__item").text
    end
  end
  
  def scrape_pet
    #need a method that accepts user input of a pet name and returns the pet's url
    #accepts argument of a pet's url
    #scrapes a pet's info
    page = Nokogiri::HTML(open('https://www.animalhumanesociety.org/animal/adoption/41683069'))
    page.css("div.animal--details-top").each do |attribute|
      gender = attribute.css(".animal--sex").text.strip
      age = attribute.css(".animal--age").text.strip
      weight = attribute.css(".animal--weight").text.strip
      fee = attribute.css(".animal--price").text.strip.gsub("Adoption Fee: ", "").gsub(/[*]/, "")
      binding.pry
    end
    
    id = page.css("div.animal--details-bottom .animal-item").first.text
  end
  
end