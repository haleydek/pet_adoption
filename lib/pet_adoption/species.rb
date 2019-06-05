#A species has many pets. Pets belong to a species.

#instantiate the species with a name, url and blank pets array
#instantiate pets when you scrape the list of pets from species url

class PetAdoption::Species
  attr_accessor :name, :pets, :url
  
  def initialize(name, url)
    @name = name
    @url = url
    @pets = []
  end
  
end