class PetAdoption::Pets
  attr_accessor :species, :name, :breed, :shelter, :url, :gender, :age, :weight, :fee, :bio
  @@all = []

  def initialize(pet_hash)
    pet_hash.each { |key, value| self.send(("#{key}="), value) }
    @@all << self
  end
  
  def self.find_or_create_from_collection(pets_array)
    pets_array.each do |hash|
      found_pet = self.all.find { |pet| pet.url == hash[:url] }
      if found_pet == nil
        self.new(hash)
      else
        found_pet
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