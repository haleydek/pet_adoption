#A species has many pets. Pets belong to a species.

class PetAdoption::Pets
  attr_accessor :species, :name, :age, :weight, :breed, :gender, :shelter, :url
  
  def create_by_species
  end
  
end