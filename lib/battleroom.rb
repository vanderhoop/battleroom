#!/usr/bin/env ruby

require 'readline'
require 'faker'
require 'awesome_print'
require 'pry'
require 'colorize'
# eliminates deprecation warning
I18n.config.enforce_available_locales = false

require_relative './battleroom/models/blank_slate'


Pry.config.default_window_size = 0
Pry.config.quiet = true
Pry.prompt = [proc { "> ".blue }, proc { "* ".blue }]
Pry.config.memory_size = 10
Pry.config.coolline_matched_paren    = "\e[m"
Pry.config.coolline_mismatched_paren    = "\e[m"

Pry::Commands.delete("exit")

# Pry::Commands.before_command("exit") do
#   puts "Before 'exit' command hook firing"
#   _pry_.eval_string = "continue"
# end

Pry::Hooks.new.clear_all
Pry.config.hooks.add_hook :before_read, :exit do |last_input, pry_instance|
  puts "last_input: #{last_input}"
  puts "pry_instance: #{pry_instance.eval_string || nil.to_s}"
end

Pry.config.hooks.add_hook :before_eval, :self_terminate do |last_input, pry_instance|

  puts "last_input: #{last_input}"
  puts "pry_instance: #{pry_instance.eval_string || nil.to_s}"
  $input = last_input
  puts ''
  pry_instance.run_command("continue")
end

# the below takes forever to load(?), so resorting to multiline requiring
  # path = File.expand_path("./battleroom/models/*.rb", File.dirname(__FILE__))
  # Dir[path].each { |file| require file }

require_relative './battleroom/models/nested_data_structure_access_question'
require_relative './battleroom/models/data_structure_assignment_question'
require_relative './battleroom/models/hash_access_question'
require_relative './battleroom/models/hash_assignment_question'
require_relative './battleroom/models/array_access_question'
require_relative './battleroom/models/array_assignment_question'
require_relative './battleroom/models/variable_question'
require_relative './battleroom/models/method_definition_question'

require_relative 'battleroom/battleroom_machinery'
include BattleroomMachinery

clear_display
print 'Welcome to the Battleroom.'.blue

loop do
  print_menu_options
  choice = Readline.readline('> '.blue, true)
  abort('Goodbye!'.green) if choice.match(/^(q|exit|!!!\s?)/i)
  clear_display

  # for eval
  b = binding

  case choice
  when '1'
    10.times do
      q = VariableQuestion.new(b)
      q.print_variable_assignment_prompt
      q.evaluate_variable_assignment_input
    end
  when '2'
    5.times do
      q = [ArrayAccessQuestion.new(b), HashAccessQuestion.new(b)].sample
      q.print_data_structure_access_prompt
      q.evaluate_data_structure_access_input
    end
  when '3'
    5.times do
      q = [ArrayAssignmentQuestion.new(b), HashAssignmentQuestion.new(b)].sample
      q.print_data_structure_assignment_prompt
      q.evaluate_data_structure_assignment_input
    end
  when '4'
    5.times do
      q = NestedDataStructureAccessQuestion.new(b)
      q.print_data_structure_access_prompt
      q.evaluate_data_structure_access_input
    end
  when '5'
    5.times do
      q = MethodDefinitionQuestion.new(b)
      q.print_prompt
      q.evaluate_method_definition_input()
    end
  else
    puts 'You entered a non-option. Try again.'.red
  end
end

