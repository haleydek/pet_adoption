require 'colorize'
require 'pry'
require 'nokogiri'
require 'open-uri'

class PetAdoption::CLI
  def call
    PetAdoption::Scraper.create_shelters
    PetAdoption::Scraper.create_species
    PetAdoption::Scraper.create_pets
    PetAdoption::Scraper.scrape_pet_attributes
    welcome
    menu
    reset
  end
  
  def welcome
    puts "Welcome to the Twin Cities' Animal Humane Society!"
    puts "Thank you for your interest in adopting a pet from one of our shelters!"
  end
  
  def menu
    puts "\nWould you like to view adoptable pets at a specific shelter in the Twin Cities? y/n"
    input = gets.strip
    while input != "exit"
      case input
        when "y"
          print_shelter
          input = gets.strip
          shelter = get_shelter(input)
          puts "\nOkay, great! We will show you pets from #{shelter.name}.\n\n"
          print_species
          input = gets.strip
          species = get_species(input)
          print_pets_by_shelter_and_species(shelter, species)
          input = gets.strip
          pet = get_pet_from_collection(shelter, species, input)
          print_pet_bio
        when "n"
          print_species
          input = gets.strip
          species = get_species(input)
          print_pets_by_species(species)
          input = gets.strip
          pet = get_pet(species, input)
          print_pet_bio
      end
  end
  
  def print_species
    puts "\nWe have the following types of animals available for adoption:"
    PetAdoption::Species.all.each_with_index { |species, i| puts "#{i + 1}. #{species.name}" }
    puts "\nWhich type of animal are you interested in adopting? Please enter the corresponding number."
    puts "\nOtherwise, enter exit."
  end
  
  def get_species(input)
    PetAdoption::Species.all[input.to_i - 1]
  end
  
  def print_shelter
    PetAdoption::Shelter.all.each_with_index { |shelter, i| puts "#{i + 1}. #{shelter.name}" }
    puts "\nPlease select a shelter by entering the corresponding number."
  end
  
  def get_shelter(input)
    PetAdoption::Shelter.all[input.to_i - 1]
  end
  
  def collect_pets(shelter, species)
    PetAdoption::Pets.all.select do |pet|
      pet.shelter == shelter && pet.species == species
    end
  end
  
  def get_pet_from_collection(shelter, species, input)
    collection = collect_pets(shelter, species)
    collection[input.to_i - 1]
  end
    
  
  def print_pets_by_shelter_and_species(shelter, species)
    collection = collect_pets(shelter,species)
    collection.each_with_index do |pet, index|
        puts "#{index + 1}. #{pet.name}"
        puts "   Breed: #{pet.breed}"
        puts "   Gender: #{pet.gender}"
        puts "   Age: #{pet.age}"
        puts "   Weight: #{pet.weight}"
        puts "   Adoption Fee: #{pet.fee}"
        puts "   Shelter: #{pet.shelter.name}"
        puts "---------------------------------------"
      end
    print_bio_message
  end
  
  def print_pets_by_species(species)
    species.pets.each_with_index do |pet, index|
      puts "#{index + 1}. #{pet.name}"
      puts "   Breed: #{pet.breed}"
      puts "   Gender: #{pet.gender}"
      puts "   Age: #{pet.age}"
      puts "   Weight: #{pet.weight}"
      puts "   Adoption Fee: #{pet.fee}"
      puts "   Shelter: #{pet.shelter.name}"
      puts "-----------------------------------------"
    end
    print_bio_message
  end

  def print_bio_message
    puts "\n\nIf you would like to view a specific pet's bio, please enter the corresponding number."
    puts "\nOtherwise, enter exit."
  end

  def get_pet(species, input)
    species.pets[input.to_i - 1]
  end
  
  def print_pet_bio(pet)
    puts "#{pet.name}'s Bio:"
    puts "#{pet.bio}"
  end
  
  def reset
    PetAdoption::Pets.clear
    PetAdoption::Species.clear
    PetAdoption::Shelter.clear
  end
  
end