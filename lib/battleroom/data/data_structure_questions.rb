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
  {
    data_structure: $random_names_array,
    possible_variable_names: [
      'friends',
      'enemies',
      'co_workers',
      'old_pals',
      'new_friends',
      'frenemies',
      'lovers',
      'admirers',
      'haters',
      'stalker_names'
    ].shuffle,
  },
  {
    data_structure: (7..29).to_a.shuffle,
    possible_variable_names: [
      'fav_nums',
      'lotto_nums',
      'ages_of_children',
      'favorite_years_of_life',
      'career_jersey_numbers',
      'lucky_numbers',
      'unlucky_numbers'
    ].shuffle,
  },
  {
    data_structure: [
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
      rand(0.0..100.0).round(2),
    ].uniq,
    possible_variable_names: [
      'test_scores',
      'win_percentages',
      'yield_percentages',
      'dividends',
      'multiples',
      'sums',
      'products',
      'monthly_bill_totals'
    ].shuffle,
  },
  {
    data_structure: [
      'Patches',
      'Falstaff',
      'Whiskers',
      'Trousers',
      'Sammycat',
      'Dunbar',
      'Digsy',
      'Bubs',
      'Davy',
      'Tomcat',
      'Mr. Bigglesworth',
      'Pinot',
      'Claude',
      'Jackson',
      'Bootsniffer',
      'Frank',
      'Dogboy',
      'Kittyhawk',
      'Kitty the Cat',
      'Tiny',
    ],
    possible_variable_names: [
      'cat_names',
      'cats',
      'kitties',
      'felines',
      'kittie_names'
    ].shuffle,
  },
  {
    data_structure: [
      'Fixing a Hole',
      'Michelle',
      'Hey Jude',
      'In My Life',
      'A Day in the Life',
      'If I Needed Someone',
      'Nowhere Man',
      'Dear Prudence',
      'Julia',
      'Good Night',
      'Something',
      'Sun King',
      'Carry That Weight',
      'Girl',
      'What Goes On',
      'The Word',
      'Blackbird',
      'Piggies',
      'Rocky Racoon',
      'Cry Baby Cry',
      'Taxman',
      'Eleanor Rigby',
      'Yellow Submarine',
      'Only a Northern Song',
      'Mean Mr. Mustard',
      'All My Loving',
      'Norwegian Wood',
      'Yesterday',
      'Blue Jay Way',
      'Hello, Goodbye',
      'Penny Lane',
      'All You Need is Love',
      'The Fool on the Hill',
      "I'm So Tired",
      "I'm Only Sleeping",
      "I'll Follow the Sun",
      "I'm Looking Through You",
    ],
    possible_variable_names: [
      'beatles_songs',
      'fav_beatles_tracks',
      'fab_four_tunes',
    ].shuffle,
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
      screenwriters: ['Charlie Kaufman', 'Donald Kaufman'],
    },
    possible_variable_names: ['adaptation'],
  },
  {
    data_structure: [
      'When Harry Met Sally',
      'How to Lose a Guy in 10 Days',
      'Bridesmaids',
      'Knocked Up',
      'High Fidelity',
      'Chasing Amy',
      'What Women Want',
      'Four Weddings and a Funeral',
      'About a Boy',
      'Notting Hill',
      'His Girl Friday',
      "America's Sweethearts",
      "My Best Friend's Wedding",
      "There's Something About Mary",
    ],
    possible_variable_names: ['rom_coms']
  },
  {
    data_structure: [
      'The Moon and Antartica',
      'Perfect From Now On',
      'Nighthawks at the Diner',
      'Songs From a Room',
      'Transformer',
      'Songs of Love and Hate',
      'Stereopathetic Soul Manure',
      "Frank's Wild Years",
    ],
    possible_variable_names: [
      'lyrically_brilliant_albums',
      'seminal_indie_rock_records'
    ].shuffle
  },
  {
    data_structure: [
      'Sixteen Stone',
      'Nirvana MTV Unplugged 1994',
      'Jagged Little Pill',
      'Ten',
      'Nevermind',
      'Illmatic',
      'The Downward Spiral',
      'Odelay',
      'Mellowgold',
      'All Eyez On Me',
      'Ready 2 Die',
      'Blur',
      'Parklife',
      'Definitely Maybe',
      'Keep It Like a Secret',
      '...Come Down',
      'XO',
      'Exile in Guyville',
      'The Lonesome Crowded West',
      'Crooked Rain, Crooked Rain',
      'The Blue Album',
      'Pinkerton',
      'OK Computer',
      'The Bends',
      'Slanted & Enchanted',
      "What's the Story (Morning Glory)?",
    ],
    possible_variable_names: [
      'classics_from_the_nineties',
      'nineties_classics',
    ].shuffle
  },
]

5.times do
  user = gen_user
  DATA_STRUCTURE_QUESTIONS.push(user)
  business = gen_business
  DATA_STRUCTURE_QUESTIONS.push(business)
end

4.times do
  location = gen_location
  DATA_STRUCTURE_QUESTIONS.push(location)
end

2.times do
  app = gen_app
  DATA_STRUCTURE_QUESTIONS.push(app)
end

DATA_STRUCTURE_QUESTIONS.shuffle!
