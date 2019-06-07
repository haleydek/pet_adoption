require 'pry'
require 'nokogiri'
require 'open-uri'

class PetAdoption::Scraper
  BASEPATH = 'https://www.animalhumanesociety.org'
  
  def self.get_page
    Nokogiri::HTML(open(BASEPATH + '/adoption'))
  end
  
  def self.scrape_species_index
    self.get_page.css("#block-animaltype div div li.facet-item")
  end
  
  def self.collect_species
    species_array = []
    self.scrape_species_index.each do |species_index|
      species_array << {
        :name => species_index.css("a .facet-item__value").text,
        :url => BASEPATH + species_index.css("a").attr("href").text
      }
    end
    species_array
  end
  
  def self.create_species
    species_array = self.collect_species
    PetAdoption::Species.find_or_create_by_name(species_array)
  end
    
  def self.scrape_pets_index(species_url)
    Nokogiri::HTML(open(species_url))
  end
  
  def self.collect_pets
    pets_array = []
    PetAdoption::Species.all.each do |species|
      self.scrape_pets_index(species.url).css("div.views-row").each do |pet_index|
        pets_array << {
          :species => species,
          :name => pet_index.css("div.field--name-name a").text,
          :breed => pet_index.css("div.field.field--breed").text.strip,
          :shelter => pet_index.css("div.field.field--name-field-location.field--type-entity-reference.field--label-hidden.field__item").text,
          :url => BASEPATH + pet_index.css("div.field--name-name a").attr("href").text
        }
      end
    end
    pets_array
  end
  
  def self.create_pets
    pets_array = self.collect_pets
    PetAdoption::Pets.find_or_create_from_collection(pets_array)
  end
  
  def scrape_pet_details(pet_url)

    page = Nokogiri::HTML(open('https://www.animalhumanesociety.org/animal/adoption/41683069'))
    page.css("div.animal--details-top").each do |attribute|
      gender = attribute.css(".animal--sex").text.strip
      age = attribute.css(".animal--age").text.strip
      weight = attribute.css(".animal--weight").text.strip
      fee = attribute.css(".animal--price").text.strip.gsub("Adoption Fee: ", "").gsub(/[*]/, "")
    end
    
    id = page.css("div.animal--details-bottom .animal-item").first.text
  end
  
end