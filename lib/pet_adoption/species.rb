class PetAdoption::Species
  attr_accessor :name, :url
  @@all = []
  
  def initialize(species_hash)
    species_hash.each { |key, value| self.send(("#{key}="), value) }
    @@all << self
  end
  
  def pets 
    PetAdoption::Pets.all.select { |pet| pet.species == self }
  end
  
  def self.find_or_create_by_name(species_array)
    species_array.each do |hash|
      found_species = self.all.find { |species| species.name == hash[:name] }
      if found_species == nil
        self.new(hash)
      else
        found_species
      end
    end
  end
  
  def self.all
    @@all
  end
  
  def self.clear
    self.all.clear
  end
  
end