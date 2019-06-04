class PetAdoption::CLI
  def call
    puts "Welcome to PAWS Chicago, a non-profit animal shelter organization!"
    puts "Thank you for your interest in adopting a pet from one of our shelters!"
    puts "What type of pet would you like to adopt?"
    input = gets.strip
  end
end