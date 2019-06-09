require_relative "./lib/pet_adoption/version"

Gem::Specification.new do |spec|
  spec.name          = "pet_adoption"
  spec.version       = PetAdoption::VERSION
  spec.authors       = ["Haley DeKeyser"]
  spec.email         = ["hcd09@live.com"]

  spec.summary       = "Adoptable pets at Twin Cities' Animal Humane Society"
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.executables << "run"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "colorize"
end
