class PetAdoption::Shelter
  attr_accessor :name
  @@all = []
  
  def initialize(shelter_hash)
    shelter_hash.each { |key, value| self.send(("#{key}="), value) }
    self.class.all << self
  end
  
  def self.find_or_create_by_name(shelter_array)
    shelter_array.each do |hash|
      found_shelter = self.all.find { |shelter| shelter.name == hash[:name] }
      if found_shelter == nil
        self.new(hash)
      else
        found_shelter
      end
    end
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