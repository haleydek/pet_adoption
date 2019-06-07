require 'colorize'
require 'pry'
require 'nokogiri'
require 'open-uri'

class PetAdoption::CLI
  def call
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
    
    puts "\nOur shelters have the following types of animals available for adoption: "

    print_species
    
    puts "\nWhich type of animal are you interested in adopting? Please enter the corresponding number to view the available pets."
    puts "Otherwise, enter exit."
    
    input_1 = gets.strip
    
    species = get_species_from_name(input_1)
    
    print_pets_from_species(species)
    
    puts "\nIf you are interested in viewing a specific pet's bio, please enter the corresponding number."
    puts "Otherwise, enter exit."
    
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
    puts "name: #{pet.name}"
    puts "  breed: #{pet.breed}"
    puts "  gender: #{pet.gender}"
    puts "  age: #{pet.age}"
    puts "  weight: #{pet.weight}"
    puts "  shelter: #{pet.shelter}"
    puts "  adoption fee: #{pet.fee}"
    puts "  bio: #{pet.bio}"
  end
  
  def reset
    PetAdoption::Pets.clear
    PetAdoption::Species.clear
  end
  
end