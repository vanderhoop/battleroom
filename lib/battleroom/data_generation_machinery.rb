
module DataGenerationMachinery
  def snake_case(string)
    string.downcase.gsub(',', '').gsub(' ', '_').gsub('-', '_')
  end

  def gen_random_names_array
    random_names_array = []
    200.times { random_names_array << Faker::Name.first_name }
    random_names_array.uniq
  end

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

  def gen_common_man

  end

  def gen_app
    name = Faker::App.name
    app = {
      version: Faker::App.version,
      author: Faker::App.author,
      name: name,
      released: rand(2004..2014),
    }
    data = {
      data_structure: app,
      possible_variable_names: [
        snake_case(name)
      ]
    }
  end

  def gen_user
    first_name = Faker::Name::first_name
    last_name = Faker::Name::last_name
    num_string = "#{[rand(0..9), rand(0..9), rand(0..9)][0, rand(1..4)].join}"
    user = {
      name: first_name + ' ' + last_name,
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

    data = {
      data_structure: user,
      possible_variable_names: [
        snake_case(first_name)
      ]
    }
  end

  def gen_business
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
        snake_case(name)
      ]
    }
  end

  def gen_location
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
        snake_case(city),
        "home",
        "target",
        "destination",
        "origin",
        "locale",
        "precinct",
        "site",
      ].shuffle
    }
  end
end


