require 'active_support/inflector'

def gen_phone_number
  "#{rand(1..9)}
   #{rand(0..9)}
   #{rand(0..9)}-
   #{rand(0..9)}
   #{rand(0..9)}
   #{rand(0..9)}-
   #{rand(0..9)}
   #{rand(0..9)}
   #{rand(0..9)}
   #{rand(0..9)}".gsub(" ", "").gsub("\n", "")
end

def gen_password
  possible_chars = ('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a.map(&:to_s)
  possible_chars.shuffle[0, rand(6..8)].join
end

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
].shuffle

6.times do
  first_name = Faker::Name::first_name
  last_name = Faker::Name::last_name
  num_string = "#{[rand(0..9), rand(0..9), rand(0..9)][0, rand(1..4)].join}"
  user = {
    name: first_name + " " + last_name,
    username: Faker::Internet::user_name(first_name) + num_string,
    password: gen_password,
    email: Faker::Internet.free_email(first_name),
    is_admin: [true, false].sample,
    phone: gen_phone_number,
    accepts_marketing_emails: [true, false].sample,
    accepts_promotional_emails: [true, false].sample,
    occupation: Faker::Name.title,
    zip: Faker::Address.zip
  }

  data = { data_structure: user,
    possible_variable_names: [
      first_name.downcase
    ]
  }
  DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.push(data)
end

6.times do
  name = Faker::Company.name
  business = {
    name: name,
    public_email: "#{["info", "hello", "greetings", "contact"].sample}@#{name.parameterize}.com",
    website: Faker::Internet.url("#{name.parameterize}.com", ''),
    phone_num: gen_phone_number,
    street_address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    llc: [true, false].sample,
    established: rand(1901..2014),
  }
  data = {
    data_structure: business,
    possible_variable_names: [
      name.downcase.gsub(",", "").gsub(" ", "_").underscore
    ]
  }
  DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.push(data)
end
4.times do
  which_key_to_use = [:short, :long].sample
  latitude  = { :short => :lat, :long => :latitude }
  longitude = { :short => :long, :long => :longitude }
  city = Faker::Address.city
  population = rand(130..270000)
  incorporated = population > 400 ? true : false
  location = {
    city: city,
    population: population,
    incorporated: incorporated,
    livestock: [true, false].sample,
    latitude[which_key_to_use] => Faker::Address.latitude.slice(0, rand(7..9)).to_f,
    longitude[which_key_to_use] => Faker::Address.longitude.slice(0, rand(7..9)).to_f
  }
  data = {
    data_structure: location,
    possible_variable_names: [
      city.downcase.gsub(",", "").gsub(" ", "_").underscore,
      "home",
      "target",
      "destination",
      "origin",
      "locale",
      "precinct",
      "site",
    ].shuffle
  }
  DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.push(data)
end

DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.shuffle!
