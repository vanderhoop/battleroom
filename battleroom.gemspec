Gem::Specification.new do |s|
  s.name        = 'battleroom'
  s.version     = '0.0.80'
  s.date        = '2014-11-27'
  s.description = "A REPL designed to give Ruby newbies countless reps doing simple tasks like working with variables, manipulating data structures, and defining and invoking methods."
  s.summary     = "A REPL designed to give Ruby newbies countless reps doing simple tasks like working with variables, manipulating data structures, and defining and invoking methods."
  s.authors     = ["Travis Vander Hoop"]
  s.email       = 'vanderhoop@me.com'
  s.files       = Dir['lib/   *.rb']                    +
                  Dir['lib/battleroom/config/   *.rb']  +
                  Dir['lib/battleroom/data/   *.rb']    +
                  Dir['lib/battleroom/helpers/   *.rb'] +
                  Dir['lib/battleroom/models/   *.rb']  +
                  Dir['bin/*']
  s.required_ruby_version = '>= 1.9.3'
  s.add_runtime_dependency 'faker',                   '1.4.3'
  s.add_runtime_dependency 'colorize',                '0.7.3'
  s.add_runtime_dependency 'awesome_print',           '1.2.0'
  s.add_runtime_dependency 'activesupport',           '4.1.6'
  s.add_runtime_dependency 'pry',                     '~> 0'
  s.add_runtime_dependency 'coderay',                 '1.1.0'
  s.add_runtime_dependency 'word_wrap',               '0.2.1'
  s.executables << 'battleroom'
  s.homepage    = 'https://github.com/vanderhoop/battleroom'
  s.license     = 'MIT'
end
