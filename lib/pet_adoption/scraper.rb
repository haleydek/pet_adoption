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
  
  def self.get_shelter_page
    Nokogiri::HTML(open(BASEPATH + '/about/hours-and-locations'))
  end
  
  def self.scrape_shelter_index
    self.get_shelter_page.css("div.paragraph.paragraph-1517.paragraph--simple-text.paragraph--simple-text--default div h3")
  end
  
  def self.collect_shelters
    shelter_array = []
    self.scrape_shelter_index.each do |shelter|
      shelter_array << { :name => shelter.text.strip }
    end
    shelter_array
  end
  
  def self.create_shelters
    shelter_array = self.collect_shelters
    PetAdoption::Shelter.find_or_create_by_name(shelter_array)
  end
    
  def self.scrape_pets_index(species_url)
    Nokogiri::HTML(open(species_url))
  end
  
  def self.assign_shelter_to_pet(pet_index)
    pet_shelter = pet_index.css("div.field.field--name-field-location.field--type-entity-reference.field--label-hidden.field__item").text
    PetAdoption::Shelter.all.find do |shelter|
      shelter if pet_shelter == shelter.name
    end
  end
  
  def self.collect_pets
    pets_array = []
    PetAdoption::Species.all.each do |species|
      self.scrape_pets_index(species.url).css("div.views-row").each do |pet_index|
        pets_array << {
          :species => species,
          :name => pet_index.css("div.field--name-name a").text,
          :breed => pet_index.css("div.field.field--breed").text.strip,
          :shelter => self.assign_shelter_to_pet(pet_index),
          :url => BASEPATH + pet_index.css("div.field--name-name a").attr("href").text
        }
      end
    end
    pets_array
  end
  
  def self.create_pets
    pets_array = self.collect_pets
    PetAdoption::Pets.find_or_create_from_collection(pets_array)
    binding.pry
  end
  
  def self.get_pet_page(pet_url)
    Nokogiri::HTML(open(pet_url))
  end
  
  def self.scrape_pet_attributes
    PetAdoption::Pets.all.each do |pet|
      self.get_pet_page(pet.url).css("div.animal--details-top").each do |attribute|
        pet.gender = attribute.css(".animal--sex").text.strip
        pet.age = attribute.css(".animal--age").text.strip
        pet.weight = attribute.css(".animal--weight").text.strip
        pet.fee = attribute.css(".animal--price").text.strip.gsub("Adoption Fee: ", "").gsub(/[*]/, "")
      end
      self.get_pet_page(pet.url).css("div.animal--keywords").each do |p|
        bio = p.text.split("\n").collect { |paragraph| paragraph.strip.chomp }
        pet.bio = bio.join("\n\n\t")
      end
    end
  end
  
end