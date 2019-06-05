require 'pry'
require 'nokogiri'
require 'open-uri'

class PetAdoption::CLI
  def call
    PetAdoption::Scraper.new.create_species
    puts "Welcome to the Twin Cities' Animal Humane Society!"
    puts "Thank you for your interest in adopting a pet from one of our shelters!"
    menu
  end
  
  def menu
    puts "Our shelters have the following types of animals available for adoption: "

    PetAdoption::Species.print_species
    
    puts "Which type of animal are you interested in adopting? Please enter the corresponding number to view the available pets."
    puts "Otherwise, enter exit."
    
    input = gets.strip
    
    species_url = PetAdoption::Species.get_species_url_from_name(input.to_i)
    
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
  
end