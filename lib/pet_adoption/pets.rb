#A species has many pets. Pets belong to a species.

#instantiated when pet list is scraped from species url
#add other attributes after initialization

class PetAdoption::Pets
  attr_accessor :species, :name, :breed, :shelter, :gender, :age, :weight, :fee, :id, :url
  @@all = []
  
  def initialize(species, name, breed, shelter)
    @species = species
    @name = pet.css("div.field--name-name a").text
    @breed = pet.css("div.field.field--breed").text.strip
    @shelter = pet.css("div.field.field--name-field-location.field--type-entity-reference.field--label-hidden.field__item").text
    @url = BASEPATH + pet.css("div.field--name-name a").attr("href").text
    self.class.all << self
  end
  
  def self.all
    @@all
  end
  
end