#!/usr/bin/env ruby

require 'readline'

# the below takes forever to load(?), so resorting to multiline requiring
  # path = File.expand_path("./battleroom/models/*.rb", File.dirname(__FILE__))
  # Dir[path].each { |file| require file }

require_relative './battleroom/models/nested_data_structure_access_question'
require_relative './battleroom/models/data_structure_assignment_question'
require_relative './battleroom/models/data_structure_access_question'
require_relative './battleroom/models/variable_question'

require_relative 'battleroom/battleroom_machinery'
include BattleroomMachinery

clear_display
print 'Welcome to the Battleroom.'.blue
loop do
  print_menu_options
  choice = Readline.readline('> '.blue, true)
  clear_display

  # for eval
  b = binding

  case choice
  when '1'
    10.times do
      q = VariableQuestion.new
      q.print_variable_assignment_prompt
      q.evaluate_variable_assignment_input(b)
    end
  when '2'
    5.times do
      q = DataStructureAccessQuestion.new
      q.print_data_structure_access_prompt
      q.evaluate_data_structure_access_input(b)
    end
  when '3'
    5.times do
      q = DataStructureAssignmentQuestion.new
      q.print_data_structure_assignment_prompt
      q.evaluate_data_structure_assignment_input(b)
    end
  when '4'
    5.times do
      q = NestedDataStructureAccessQuestion.new
      q.print_data_structure_access_prompt
      q.evaluate_data_structure_access_input(b)
    end
  when /^(q|exit|!!!\s?)/i
    puts 'Goodbye!'.green
    break
  else
    puts 'You entered a non-option. Try again.'.red
  end
end

