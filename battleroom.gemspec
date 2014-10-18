Gem::Specification.new do |s|
  s.name        = 'battleroom'
  s.version     = '0.0.74'
  s.date        = '2014-10-01'
  s.description = "A simple command-line REPL designed to give Ruby newbies countless reps doing simple tasks like assigning variables and accessing and assigning values within nested data structures."
  s.summary     = "A simple command-line REPL designed to give Ruby newbies countless reps doing simple tasks like assigning variables and accessing and assigning values within nested data structures."
  s.authors     = ["Travis Vander Hoop"]
  s.email       = 'vanderhoop@me.com'
  s.files       = [
    "lib/battleroom.rb",
    "lib/battleroom/battleroom_machinery.rb",
    "lib/battleroom/data_generation_machinery.rb",
    "lib/battleroom/data/array_questions.rb",
    "lib/battleroom/data/hash_questions.rb",
    "lib/battleroom/data/nested_data_structure_access_questions.rb",
    "lib/battleroom/data/variable_assignment_questions.rb",
    "lib/battleroom/models/question.rb",
    "lib/battleroom/models/data_structure_question.rb",
    "lib/battleroom/models/nested_data_structure_access_question.rb",
    "lib/battleroom/models/data_structure_access_question.rb",
    "lib/battleroom/models/data_structure_assignment_question.rb",
    "lib/battleroom/models/hash_access_question.rb",
    "lib/battleroom/models/hash_assignment_question.rb",
    "lib/battleroom/models/array_access_question.rb",
    "lib/battleroom/models/array_assignment_question.rb",
    "lib/battleroom/models/variable_question.rb",
  ]
  s.required_ruby_version = '>= 1.9.3'
  s.add_runtime_dependency 'faker',    '1.4.3'
  s.add_runtime_dependency 'colorize', '0.7.3'
  s.add_runtime_dependency 'awesome_print', '1.2.0'
  s.executables << 'battleroom'
  s.homepage    = 'https://github.com/vanderhoop/battleroom'
  s.license     = 'MIT'
end
