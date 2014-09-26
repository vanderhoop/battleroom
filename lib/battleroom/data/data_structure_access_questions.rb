require_relative '../data_generation_machinery'
include DataGenerationMachinery

require 'pry'
require 'Faker'
# eliminates deprecation warning
I18n.config.enforce_available_locales = false


$random_names_array = gen_random_names_array

DATA_STRUCTURE_ACCESS_QUESTIONS = [
  {
    data_structure: [
      "Foundation",
      "American Gods",
      "The Dark Tower",
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
      "The Time Machine",
      "Ender's Game",
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
      'fab_four_tunes'
    ].shuffle,
  },
  # {
  #   data_structure: ["When Harry Met Sally", "There's Something About Mary", "How to Lose a Guy in 10 Days", "Bridesmaids", "Knocked Up", "High Fidelity", "America's Sweethearts", "My Best Friend's Wedding", "Chasing Amy", "What Women Want", "Four Weddings and a Funeral", "About a Boy", "Notting Hill", "His Girl Friday"],
  #   possible_variable_names: ["rom_coms"]
  # },
  # {
  #   data_structure: ["The Moon and Antartica", "Frank's Wild Years", "Perfect From Now On", "Nighthawks at the Diner", "Songs From a Room", "Transformer", "Songs of Love and Hate", "Stereopathetic Soul Manure"],
  #   possible_variable_names: ["lyrically_brilliant_albums"].shuffle
  # },
  # {
  #   data_structure: ["Sixteen Stone", "Nirvana MTV Unplugged 1994", "Jagged Little Pill", "Ten", "Nevermind", "Illmatic", "The Downward Spiral", "Odelay", "Mellowgold", "All Eyez On Me", "Ready 2 Die", "Blur", "Parklife", "What's the Story (Morning Glory)?", "Definitely Maybe", "Keep It Like a Secret", "...Come Down", "XO", "Exile in Guyville", "The Lonesome Crowded West", "Crooked Rain, Crooked Rain", "The Blue Album", "Pinkerton", "OK Computer", "The Bends", "Slanted & Enchanted"],
  #   possible_variable_names: ["classics_from_the_nineties"].shuffle
  # },
  # {
  #   data_structure: {
  #     tiring: true,
  #     distance: "13.1 miles",
  #   },
  #   possible_variable_names: ["brooklyn_half_marathon", "madison_half_marathon"],
  #   possible_assignments: [
  #     { distance_in_km: 21.097 },
  #     { top_sponsor: "New Balance" },
  #     { season: "spring" },
  #   ],
  # },
  {
    data_structure: {
      home_team: 'Green Bay Packers',
      capacity: 72_928,
    },
    possible_variable_names: ['lambeau_field'],
    possible_assignments: [
      { real_grass: true },
      { price_of_beer: 5.5 },
      { namesake: 'Curly Lambeau' },
      { address: '1265 Lombardi' },
      { executive_suite_count: 168 },
      { championship_banners: true },
      { state: 'WI' },
      { city: 'Green Bay' }
    ],
  },
  {
    data_structure: {
      stars: ['Ryan Gosling', 'Rachel McAdams'],
      released: 2004,
    },
    possible_variable_names: ['the_notebook'],
    possible_assignments: [
      { tearjerker: true },
      { director: 'Nick Cassavetes' },
      { mtv_movie_award_count: 1 },
      { box_office_millions: 81.5 },
      { macho: false },
    ]
  },
  # {
  #   data_structure: {
  #     director: "Spike Jonze",
  #     released: 1999,
  #   },
  #   possible_variable_names: ["being_john_malkavich"],
  #   possible_assignments: [
  #     { stars: ["John Cusack", "Cameron Diaz"] },
  #     { screenwriter: "Charlie Kaufman" },
  #     { rt_rating: 93.0 },
  #     { charlie_sheen_cameo: true },
  #   ]
  # },
  {
    data_structure: {
      stars: ['Nicholas Cage', 'Meryl Streep'],
      rt_rating: 98.0,
      released: 2002,
      charlie_sheen_cameo: true,
      screenwriters: ['Charlie Kaufman', 'Donald Kaufman'],

    },
    possible_variable_names: ['adaptation'],
  },
]

#======================================
# Dynamically Generated Data Structures
#======================================

4.times do

  # name = $random_names_array.sample
  # data = {
  #   data_structure: {
  #     name: name,
  #     occupation: ["doctor", "roofer", "mason", "booky", "cobbler"].sample,
  #     # fav_band: ["Pavement", "Suede", "Pixies", "Pearl Jam", "Ani Defranco"].sample,
  #     phone: gen_phone_number,
  #     single: [true, false].sample,
  #     # has_pets: [true, false].sample,
  #     # has_drivers_license: [true, false].sample,
  #     best_friend: $random_names_array.sample,
  #   },
  #   possible_variable_names: [name.downcase.gsub(",", "").gsub(" ", "_")]
  # }
  # DATA_STRUCTURE_ACCESS_QUESTIONS.push(data)

  # data = {
  #   data_structure: {
  #     name: $random_names_array.sample,
  #     age: rand(21..33),
  #     fav_band: [
  #        'Weezer',
  #        'Nirvana',
  #        'Missy Elliott',
  #        'Elliott Smith',
  #        'Phish',
  #        '2pac',
  #        'Kanye West'
  #      ].sample,
  #     parent: [true, false].sample
  #   },
  #   possible_variable_names: [
  #     'bus_driver',
  #     'larsony_suspect',
  #     'head_roady',
  #     'crew_chief',
  #     'adjunct_professor',
  #     'fav_dog_walker',
  #     'street_person',
  #     'instructor',
  #     'lover',
  #     'fighter',
  #     'destroyer',
  #     'troublemaker',
  #     'seeker',
  #   ].shuffle,
  # },
  # DATA_STRUCTURE_ACCESS_QUESTIONS.push(data)
end

10.times do
  user = gen_user
  DATA_STRUCTURE_ACCESS_QUESTIONS.push(user)
  # app = gen_app
  # DATA_STRUCTURE_ACCESS_QUESTIONS.push(app)
end

DATA_STRUCTURE_ACCESS_QUESTIONS.shuffle
