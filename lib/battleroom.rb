#!/usr/bin/env ruby

require 'readline'
require 'faker'
require 'awesome_print'
require 'pry'
require 'colorize'
require 'coderay'
require 'word_wrap'

path = File.expand_path("./battleroom/models/*.rb", File.dirname(__FILE__))
Dir[path].each { |file| require file }

require_relative './battleroom/config/pry_config'

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
      q = VariableAssignmentQuestion.new(b)
      if q.variable_value == true || q.variable_value == false
        reassignment_q = VariableReassignmentQuestion.new(b, q)
      else
        follow_up_question = VariableReferenceQuestion.new(b, q)
      end
    end
  when '2'
    5.times do
      q = [ArrayAccessQuestion.new(b), HashAccessQuestion.new(b)].sample
    end
  when '3'
    5.times do
      q = [ArrayAssignmentQuestion.new(b), HashAssignmentQuestion.new(b)].sample
    end
  when '4'
    5.times do
      q = MethodDefinitionQuestion.new(b)
      follow_up_question = MethodInvocationQuestion.new(b, q)
      follow_up_question.print_method_invocation_prompt
      follow_up_question.evaluate_user_input
    end
  when '5'
    5.times do
      q = NestedDataStructureAccessQuestion.new(b)
      q.print_data_structure_access_prompt
      q.evaluate_data_structure_access_input
    end
  else
    battleprint 'You entered a non-option. Try again.'.red
  end
end

