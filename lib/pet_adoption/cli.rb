class PetAdoption::CLI
  def call
    Scraper.scrape_index_page
    puts "Welcome to PAWS Chicago!"
    puts "Thank you for your interest in adopting a pet from one of our shelters!"
    menu
  end
  
  def menu
    puts "Our shelters have cats and dogs available for adoption."
    puts "To view a list of the available cats, please enter cats."
    puts "To view a list of the available dogs, please enter dogs."
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