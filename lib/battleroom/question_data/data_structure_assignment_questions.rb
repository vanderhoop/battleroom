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
      executive_suite_count: 168,
      banners: true,
    },
    possible_variable_names: ["lambeau_field"],
  },
  # {
  #   data_structure: [
  #     "Ender's Game",
  #     "Foundation",
  #     "Dune",
  #     "Cat's Cradle",
  #     "The Left Hand of Darkness",
  #     "Hitchhiker's Guide to the Galaxy",
  #     "Stranger in a Strange Land",
  #     "Sirens of Titan",
  #     "Brave New World",
  #     "Lord of the Rings",
  #     "1984",
  #     "Farhenheit 451",
  #     "Animal Farm",
  #     "Watchmen",
  #     "The Stand",
  #     "2001",
  #     "Starship Troopers",
  #     "The Time Machine"
  #   ],
  #   possible_variable_names: [
  #     "sci_fi_books",
  #     "sci_fi_novels",
  #     "canonical_sci_fi_titles",
  #     "science_fiction_titles",
  #     "books",
  #     "paperback_titles"
  #   ].shuffle,
  # },
].shuffle

10.times do
  first_name = Faker::Name::first_name
  last_name = Faker::Name::last_name
  num_string = "#{[rand(0..9), rand(0..9), rand(0..9)][0, rand(1..4)].join}"
  user = {
    name: first_name + " " + last_name,
    username: Faker::Internet::user_name(first_name) + num_string,
    password: Faker::Internet.password(8),
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
      "user_1",
      first_name.downcase
    ]
  }
  DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.push(data)
end

DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.shuffle!
