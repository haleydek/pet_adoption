require 'pry'
require 'nokogiri'
require 'open-uri'

class PetAdoption::CLI
  def call
    PetAdoption::Scraper.new.scrape_pets_by_species
    puts "Welcome to the Twin Cities' Animal Humane Society!"
    puts "Thank you for your interest in adopting a pet from one of our shelters!"
    menu
  end
  
  def menu
    puts "Our shelters have the following animal types available for adoption: "
     #print animal types from PetAdoption::Scraper.get_pet_types
    puts "Otherwise, enter exit."
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
  
  def list_cats
    #lists all of the cats available for adoption
  end
  
  def list_dogs
    #lists all of the dogs available for adoption
  end
  
end