require 'active_support/inflector'
require_relative '../data_generation_machinery'
include DataGenerationMachinery

DATA_STRUCTURE_ASSIGNMENT_QUESTIONS = [
  {
    data_structure: {
      home_team: "Green Bay Packers",
      capacity: 72_928,
      established: 1957,
      publicly_owned: true,
      real_grass: true,
      price_of_beer: 5.5,
      namesake: "Curly Lambeau",
      address: "1265 Lombardi",
      suite_count: 168,
      banners: true,
    },
    possible_variable_names: ["lambeau_field"],
  },
  {
    data_structure: [
      "Ender's Game",
      "Foundation",
      "American Gods",
      "The Gunslinger",
      "Do Androids Dream of Electric Sheep?",
      "A Scanner Darkly",
      "We Can Build You",
      "Dune",
      "Cat's Cradle",
      "The Left Hand of Darkness",
      "Hitchhiker's Guide to the Galaxy",
      "Stranger in a Strange Land",
      "Sirens of Titan",
      "Brave New World",
      "Lord of the Rings",
      "1984",
      "Farhenheit 451",
      "Animal Farm",
      "Watchmen",
      "The Stand",
      "2001",
      "Starship Troopers",
      "The Time Machine"
    ],
    possible_variable_names: [
      "sci_fi_books",
      "sci_fi_novels",
      "canonical_sci_fi_titles",
      "science_fiction_titles",
      "books",
      "paperback_titles"
    ].shuffle,
  },
]

6.times do
  user = gen_user
  DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.push(user)
  business = gen_business
  DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.push(business)
end

4.times do
  location = gen_location
  DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.push(location)
end

DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.shuffle!
