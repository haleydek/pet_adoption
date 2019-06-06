require 'pry'
require 'nokogiri'
require 'open-uri'

class PetAdoption::Scraper
  BASEPATH = 'https://www.animalhumanesociety.org'
  
  def get_page
    Nokogiri::HTML(open(BASEPATH + '/adoption'))
  end
  
  def scrape_species_index
    self.get_page.css("#block-animaltype div div li.facet-item")
  end
  
  def create_species
    scrape_species_index.each do |s|
      PetAdoption::Species.new_from_species_index(s)
    end
  end
    
  def self.scrape_pets_index(species_url)
    Nokogiri::HTML(open(species_url))
  end
  
  def self.create_pets
    pets = []
    PetAdoption::Species.all.each do |species|
      self.scrape_pets_index(species.url).css("div.views-row").each do |pet_index|
        pets << {
          :species => species,
          :name => pet_index.css("div.field--name-name a").text,
          :breed => pet_index.css("div.field.field--breed").text.strip,
          :shelter => pet_index.css("div.field.field--name-field-location.field--type-entity-reference.field--label-hidden.field__item").text,
          :url => BASEPATH + pet_index.css("div.field--name-name a").attr("href").text
        }
      end
    end
    pets
  end
  
  
  def scrape_pet_details(pet_url)
    #need a method that accepts user input of a pet name and returns the pet's url
    #accepts argument of a pet's url
    #scrapes a pet's info
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