require 'readline'
require 'faker'
require 'awesome_print'
require 'pry'
require 'colorize'
require 'coderay'
require 'word_wrap'

path = File.expand_path("../models/*.rb", File.dirname(__FILE__))
Dir[path].each { |file| require file }

require_relative './pry_config'

require_relative '../battleroom_machinery'

include BattleroomMachinery


