#A species has many pets. Pets belong to a species.

#instantiated when pet list is scraped from species url
#add other attributes after initialization

class PetAdoption::Pets
  attr_accessor :species, :name, :breed, :shelter, :gender, :age, :weight, :fee, :id, :url
  BASEPATH = 'https://www.animalhumanesociety.org'
  @@all = []
  
  def initialize(name, breed, shelter, url)
    @name = name
    @breed = breed
    @shelter = shelter
    @url = url
    self.class.all << self
  end
  
  def self.find_or_create_from_pet_index(pet_index)
    name = pet_index.css("div.field--name-name a").text
    breed = pet_index.css("div.field.field--breed").text.strip
    shelter = pet_index.css("div.field.field--name-field-location.field--type-entity-reference.field--label-hidden.field__item").text
    url = BASEPATH + pet_index.css("div.field--name-name a").attr("href").text
    
    found_pet = self.all.find { |pet| pet.url == url }
    
    if found_pet == nil
      self.new(name, breed, shelter, url)
    else
      found_pet
    end
  end
    
  
  def self.all
    @@all
  end
  
end