Gem::Specification.new do |s|
  s.name        = 'battleroom'
  s.version     = '0.0.2'
  s.date        = '2010-04-28'
  s.summary     = "A simple command-line REPL designed to give Ruby newbies countless reps doing simple tasks like assigning variables and accessing and assigning values within nested data structures."
  s.description = "A Battleroom"
  s.authors     = ["Travis Vander Hoop"]
  s.email       = 'vanderhoop@me.com'
  s.files       = [
    "lib/battleroom.rb",
    "lib/battleroom/battleroom_machinery.rb",
    "lib/battleroom/data/array_questions.rb",
    "lib/battleroom/data/hash_questions.rb",
    "lib/battleroom/data/nested_data_structure_access_questions.rb",
    "lib/battleroom/data/variable_assignment_questions.rb"
  ]
  s.required_ruby_version = '>= 1.9.3'
  s.add_runtime_dependency 'colorize', '~> 0.7', '>= 0.7.3'
  s.add_runtime_dependency 'faker',    '~> 1.3.0', '>= 1.3.0'
  s.executables << 'battleroom'
  s.homepage    = 'https://github.com/vanderhoop/battleroom'
  s.license     = 'MIT'
end
