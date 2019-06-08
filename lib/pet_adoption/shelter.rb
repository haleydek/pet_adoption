class PetAdoption::Shelter
  attr_accessor :name
  @@all = []
  
  def initialize(name)
    @name = name
  end
  
  def pets
    PetAdoption::Pets.all.select { |pet| pet.shelter == self }
  end
  
  def self.all
    @@all
  end
  
  def self.clear
    self.all.clear
  end
  
end