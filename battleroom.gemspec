Gem::Specification.new do |s|
  s.name        = 'battleroom'
  s.version     = '0.0.1x'
  s.date        = '2010-04-28'
  s.summary     = "A simple command-line REPL designed to give Ruby newbies countless reps doing simple tasks like assigning variables and accessing and assigning values within nested data structures."
  s.description = "A Battleroom"
  s.authors     = ["Travis Vander Hoop"]
  s.email       = 'vanderhoop@me.com'
  s.files       = ["lib/battleroom.rb", "lib/battleroom/battleroom_machinery.rb", "lib/battleroom/question_data/data_structure_access.rb", "lib/battleroom/question_data/variable_assignment.rb"]
  s.executables << 'battleroom'
  s.homepage    = 'https://github.com/vanderhoop/battleroom'
  s.license     = 'MIT'
end
