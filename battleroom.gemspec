Gem::Specification.new do |s|
  s.name        = 'battleroom'
  s.version     = '0.0.79'
  s.date        = '2014-11-05'
  s.description = "A command-line REPL designed to give novice Ruby programmers countless reps doing simple tasks like assigning variables, working with data structures, and defining and invoking methods."
  s.summary     = "A command-line REPL designed to give novice Ruby programmers countless reps doing simple tasks like assigning variables, working with data structures, and defining and invoking methods."
  s.authors     = ["Travis Vander Hoop"]
  s.email       = 'vanderhoop@me.com'
  s.files       = [
    "lib/battleroom.rb",
    "lib/battleroom/config/pry_config.rb",
    "lib/battleroom/battleroom_machinery.rb",
    "lib/battleroom/data_generation_machinery.rb",
    "lib/battleroom/data/array_questions.rb",
    "lib/battleroom/data/hash_questions.rb",
    "lib/battleroom/data/method_questions.rb",
    "lib/battleroom/data/nested_data_structure_access_questions.rb",
    "lib/battleroom/data/variable_assignment_questions.rb",
    "lib/battleroom/models/question.rb",
    "lib/battleroom/models/method_definition_question.rb",
    "lib/battleroom/models/method_invocation_question.rb",
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
  s.add_runtime_dependency 'faker',         '1.4.3'
  s.add_runtime_dependency 'colorize',      '0.7.3'
  s.add_runtime_dependency 'awesome_print', '1.2.0'
  s.add_runtime_dependency 'activesupport-inflector', '4.1.6'
  s.add_runtime_dependency 'pry',           '~> 0'
  s.add_runtime_dependency 'coderay',       '1.1.0'
  s.add_runtime_dependency 'word_wrap',     '0.2.1'
  s.executables << 'battleroom'
  s.homepage    = 'https://github.com/vanderhoop/battleroom'
  s.license     = 'MIT'
end
