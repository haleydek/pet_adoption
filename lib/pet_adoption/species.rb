#A species has many pets. Pets belong to a species.
#instantiate pets when you scrape the list of pets from species url

class PetAdoption::Species
  attr_accessor :name, :url
  @@all = []
  BASEPATH = 'https://www.animalhumanesociety.org'
  
  def initialize(name, url)
    @name = name
    @url = url
    #@pets = [] !!not single source of truth
    self.class.all << self
  end
  
  #def add_pet(pet)
  #  @pets << pet
  #  pet.species = self
  #end
  
  def pets 
    PetAdoption::Pets.all.select do |pet| 
      pet.species == self 
    end 
  end
  
  def self.new_from_species_index(s)
    self.new(s.css("a .facet-item__value").text, BASEPATH + s.css("a").attr("href").text)
  end
  
  #not sure if I need #find_by_name for the species
  def self.find_by_name(name)
    found_species = self.all.find { |species| species.name == name }
    found_species
  end
  
  def self.all
    @@all
  end
  
end