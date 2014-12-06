Gem::Specification.new do |s|
  s.name        = 'battleroom'
  s.version     = '0.0.83'
  s.date        = '2014-12-06'
  s.description = "A REPL designed to give Ruby newbies countless reps doing simple tasks like working with variables, manipulating data structures, and defining and invoking methods."
  s.summary     = "A REPL designed to give Ruby newbies countless reps doing simple tasks like working with variables, manipulating data structures, and defining and invoking methods."
  s.authors     = ["Travis Vander Hoop"]
  s.email       = 'vanderhoop@me.com'
  s.files       = Dir['lib/battleroom/**/*.rb'] +
                  Dir['lib/*.rb']               +
                  Dir['bin/*']
  s.required_ruby_version = '>= 2.1.0'
  s.add_runtime_dependency 'faker',                   '1.4.3'
  s.add_runtime_dependency 'colorize',                '0.7.3'
  s.add_runtime_dependency 'awesome_print',           '1.2.0'
  s.add_runtime_dependency 'activesupport',           '4.1.6'
  s.add_runtime_dependency 'pry',                     '0.10.1'
  # s.add_runtime_dependency 'debugger-ruby_core_source', '~> 1.3', '>= 1.3.7'
  s.add_runtime_dependency 'pry-byebug',              '~> 2.0'
  s.add_runtime_dependency 'coderay',                 '1.1.0'
  s.add_runtime_dependency 'word_wrap',               '0.2.1'
  s.executables << 'battleroom'
  s.homepage    = 'https://github.com/vanderhoop/battleroom'
  s.license     = 'MIT'
end
