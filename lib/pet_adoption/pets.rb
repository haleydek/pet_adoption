#A species has many pets. Pets belong to a species.

class PetAdoption::Pets
  attr_accessor :species, :name, :breed, :shelter,  :gender, :age, :weight, :fee, :url
  
  def create_by_species
  end
  
end