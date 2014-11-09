require_relative '../data_generation_machinery'
include DataGenerationMachinery
require 'active_support/inflector'
require 'faker'

#=======================================
# Contribution Guidelines
#=======================================

# 1. All hashes must have *at least* 5 key values pairs.
# 2. All questions must have a possible variables names key, be hashes with *at least* 5 key values pairs

HASH_QUESTIONS = [
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
    data_structure: {
      stars: ['Ryan Gosling', 'Rachel McAdams'],
      released: 2004,
      tearjerker: true,
      director: 'Nick Cassavetes',
      mtv_movie_award_count: 1,
      box_office_millions: 81.5,
      macho: false,
    },
    possible_variable_names: ['the_notebook'],
  },
  {
    data_structure: {
      stars: ['Nicholas Cage', 'Meryl Streep'],
      rt_rating: 98.0,
      released: 2002,
      director: 'Spike Jonze',
      based_on: 'The Orchid Thief',
      screenwriters: ['Charlie Kaufman', 'Donald Kaufman'],
    },
    possible_variable_names: ['adaptation'],
  },
]

HASH_QUESTIONS

5.times do
  user = gen_user
  HASH_QUESTIONS.push(user)
  business = gen_business
  HASH_QUESTIONS.push(business)
end

4.times do
  location = gen_location
  HASH_QUESTIONS.push(location)
end

HASH_QUESTIONS.shuffle!
