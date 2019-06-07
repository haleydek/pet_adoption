require 'pry'
require 'nokogiri'
require 'open-uri'

class PetAdoption::CLI
  def call
    PetAdoption::Scraper.create_species
    PetAdoption::Scraper.create_pets
    PetAdoption::Scraper.scrape_pet_attributes
    puts "Welcome to the Twin Cities' Animal Humane Society!"
    puts "Thank you for your interest in adopting a pet from one of our shelters!"
    menu
  end
  
  def menu
    
    puts "\nOur shelters have the following types of animals available for adoption: "

    print_species
    
    puts "\nWhich type of animal are you interested in adopting? Please enter the corresponding number to view the available pets."
    puts "Otherwise, enter exit."
    
    input_1 = gets.strip
    
    species = get_species_from_name(input_1)
    
    print_pets_from_species(species)
    
    input_2 = gets.strip
    
    pet = get_pet(species, input_2)
    
    print_pet_attributes(pet)
    
    #scrape species page to get list of pets
    #print list of pets
    
    #user selects a pet
    #print pet's full bio
    
    #need a method that accepts user input of a pet name and returns the pet's url
    #accepts argument of a pet's url
    #scrapes a pet's info
    
    # input = nil
    # while input != "exit"
    #   case input
    #     when "cat"
    #       puts "list of cats"
    #       #execute list of cats
    #     when "dog"
    #       puts "list of dogs"
    #       #execute list of dogs
    #   end
    # end
  end
  
  def print_species
    PetAdoption::Species.all.each_with_index { |species, i| puts "#{i + 1}. #{species.name}" }
  end
  
  def get_species_from_name(input_1)
    PetAdoption::Species.all[input_1.to_i - 1]
  end
  
  def print_pets_from_species(species)
    species.pets.each_with_index do |pet, index|
      puts "#{index + 1}. #{pet.name} - #{pet.breed}"
    end
  end
  
  def get_pet(species, input_2)
    species.pets[input_2.to_i - 1]
  end
  
  def print_pet_attributes(pet)
    pet.each { |key, value| puts "\n#{key}: #{value}" }
  end
  
end