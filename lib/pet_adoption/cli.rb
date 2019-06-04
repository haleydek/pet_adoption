class PetAdoption::CLI
  def call
    puts "Welcome to PAWS Chicago, a non-profit animal shelter organization!"
    puts "Thank you for your interest in adopting a pet from one of our shelters!"
    menu
  end
  
  def menu
    puts "Our shelters have cats and dogs available for adoption."
    puts "To view all of the available cats, please enter cat."
    puts "To view all of the available dogs, please enter dog."
    puts "Otherwise, enter exit."
    input = nil
    while input != "exit"
      case input
        when "cat"
          puts "list of cats"
          #execute list of cats
        when "dog"
          puts "list of dogs"
          #execute list of dogs
      end
    end
  end
  
  def get_cats
    #lists all of the cats available for adoption
  end
  
  def get_dogs
    #lists all of the dogs available for adoption
  end
  
end