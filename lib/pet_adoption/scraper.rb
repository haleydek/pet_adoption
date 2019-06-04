class PetAdoption::Scraper
  def scrape_index_page
    index_page = Nokogiri::HTML(open('http://www.pawschicago.org/our-work/pet-adoption/pets-available/'))
    pets = []
    pet_types = ["cats", "dogs"]
    pet_types.each do |type|
      index_page.css("div.pets-placeholder article.#{type}").each do |pet_block|
        pet.css("div.adopt-pet a").each do |pet|
          pet_profile_link = "#{pet.attr("href")}"
          pet_name = pet.css("h3").text
          pet_location = pet.css("h6").text
          pet_type = "#{type}"
          pets << { name: pet_name, location: pet_location, type: pet_type, profile_link: pet_profile_link }
        end
      end
    end
    pets
  end
end