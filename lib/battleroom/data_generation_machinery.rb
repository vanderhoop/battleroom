module DataGenerationMachinery

  def snake_case(string)
    string.downcase.gsub(',', '').gsub(' ', '_').gsub('-', '_').gsub("'", '')
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

  def gen_user
    password_or_pw = [:password, :pw].sample
    admin_or_is_admin = [:admin, :is_admin].sample
    phone_of_phone_num = [:phone, :phone_num, :phone_number].sample
    occupation_or_job_title = [:occupation, :job_title].sample
    zip_or_zip_code = [:zip, :zip_code].sample
    first_name = Faker::Name::first_name
    last_name = Faker::Name::last_name
    num_string = "#{[rand(0..9), rand(0..9), rand(0..9)][0, rand(1..4)].join}"
    user = {
      name: first_name + ' ' + last_name,
      username: Faker::Internet::user_name(first_name) + num_string,
      password_or_pw => gen_password,
      email: Faker::Internet.free_email(first_name),
      admin_or_is_admin => [true, false].sample,
      phone_of_phone_num => gen_phone_number,
      accepts_marketing: [true, false].sample,
      accepts_promotional_emails: [true, false].sample,
      occupation_or_job_title => Faker::Name.title,
      zip_or_zip_code => Faker::Address.zip
    }

    data = {
      data_structure: user,
      possible_variable_names: [
        snake_case(first_name),
        snake_case(first_name),
        snake_case(first_name),
        snake_case(first_name),
        'current_user'
      ].shuffle
    }
  end

  def gen_business_email_address(business_name)
    possible_intro_words = ['info', 'hello', 'greetings', 'contact', 'team']
    intro_word = possible_intro_words.sample
    biz_email_address = "#{intro_word}@#{business_name.parameterize}.com"
  end

  def gen_business
    name_or_business_name = [:name, :business_name].sample
    email_key = [:email, :public_email, :info_email, :contact_email].sample
    web_key = [:url, :website, :homepage_url].sample
    address_key = [:street_address, :address].sample
    established_key = [:established, :inception_year].sample
    name = Faker::Company.name
    email_address = gen_business_email_address(name)
    business = {
      name_or_business_name => name,
      public_email: email_address,
      web_key => Faker::Internet.url("#{name.parameterize}.com", ''),
      phone_num: gen_phone_number,
      address_key => Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      established_key => rand(1901..2014),
    }
    data = {
      data_structure: business,
      possible_variable_names: [
        snake_case(name),
        snake_case(name),
        snake_case(name),
        'client',
      ].shuffle
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
        'home',
        'target',
        'destination',
        'origin',
        'locale',
        'precinct',
        'site',
      ].shuffle
    }
  end
end


