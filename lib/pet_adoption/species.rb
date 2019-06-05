#A species has many pets. Pets belong to a species.

#instantiate the species with a name, url and blank pets array
#instantiate pets when you scrape the list of pets from species url

class PetAdoption::Species
  attr_accessor :name, :pets, :url
  @@all = []
  BASEPATH = 'https://www.animalhumanesociety.org'
  
  def initialize(name, url)
    @name = name
    @url = url
    @pets = []
    self.class.all << self
  end
  
  def self.new_from_species_index(s)
    self.new(s.css("a .facet-item__value").text, BASEPATH + s.css("a").attr("href").text)
  end
  
  def self.all
    @@all
  end
  
  def self.print_species
    self.all.each_with_index { |species, i| puts "#{i + 1}. #{species.name}" }
  end
  
  def self.get_species_url_from_name(input.to_i)
    i = 0
    self.all.find do |species|
      return species.url when i == input
      i += 1
    end
  end
  
end