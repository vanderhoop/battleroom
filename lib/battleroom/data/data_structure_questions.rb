require 'pry'
require 'Faker'
# eliminates deprecation warning
I18n.config.enforce_available_locales = false

require_relative '../data_generation_machinery'
include DataGenerationMachinery
require 'active_support/inflector'

$random_names_array = gen_random_names_array

DATA_STRUCTURE_QUESTIONS = [
  {
    data_structure: {
      home_team: 'Green Bay Packers',
      capacity: 72_928,
      established: 1957,
      publicly_owned: true,
      real_grass: true,
      price_of_beer: 5.5,
      namesake: 'Curly Lambeau',
      address: '1265 Lombardi',
      suite_count: 168,
      banners: true,
    },
    possible_variable_names: ['lambeau_field', 'the_frozen_tundra'],
  },
  {
    data_structure: [
      'Foundation',
      'American Gods',
      'The Gunslinger',
      'Do Androids Dream of Electric Sheep?',
      'A Scanner Darkly',
      'We Can Build You',
      'Dune',
      'The Left Hand of Darkness',
      'Stranger in a Strange Land',
      'Sirens of Titan',
      'Brave New World',
      'Lord of the Rings',
      '1984',
      'Farhenheit 451',
      'Animal Farm',
      'Watchmen',
      'The Stand',
      '2001',
      'Starship Troopers',
      'The Time Machine',
      "Hitchhiker's Guide to the Galaxy",
      "Cat's Cradle",
      "Ender's Game",
    ],
    possible_variable_names: [
      'sci_fi_books',
      'sci_fi_novels',
      'canonical_sci_fi_titles',
      'science_fiction_titles',
      'books',
      'paperback_titles',
    ].shuffle,
  },
]

6.times do
  user = gen_user
  DATA_STRUCTURE_QUESTIONS.push(user)
  business = gen_business
  DATA_STRUCTURE_QUESTIONS.push(business)
end

4.times do
  location = gen_location
  DATA_STRUCTURE_QUESTIONS.push(location)
  app = gen_app
  DATA_STRUCTURE_QUESTIONS.push(app)
end

DATA_STRUCTURE_QUESTIONS.shuffle!
