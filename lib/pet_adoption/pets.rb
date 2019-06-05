#A species has many pets. Pets belong to a species.

#instantiated when pet list is scraped from species url
#add other attributes after initialization

class PetAdoption::Pets
  attr_accessor :species, :name, :breed, :shelter, :gender, :age, :weight, :fee, :id, :url
  
  def initialize(species, name, breed, shelter)
    @species = species
    @name = name
    @breed = breed
    @shelter = shelter
  end
  
end