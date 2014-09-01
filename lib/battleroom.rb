#!/usr/bin/env ruby

require_relative 'battleroom/battleroom_machinery'
include BattleroomMachinery

clear_display
print "Welcome to the Battleroom.".blue
while true
  print_menu_options
  choice = Readline.readline("> ", true)
  clear_display

  # for eval
  b = binding

  case choice
  when "1"
    10.times do
      q = Question.new(:variable, VARIABLE_QUESTIONS.sample)
      q.print_variable_assignment_prompt
      # q.evaluate_variable_assignment(b)
      q.evaluate_variable_assignment_input(b)
    end
  when "2"
    5.times do
      data_structure_question = Question.new(:data_structure_access, DATA_STRUCTURE_ACCESS_QUESTIONS.sample)
      data_structure_question.print_data_structure_access_prompt
      # data_structure_question.evaluate_data_structure_access_response(b)
      data_structure_question.evaluate_data_structure_access_input(b)
    end
  when /^(q|exit\s?)/i
    puts "Goodbye!".green
    break
  else
    puts "You entered a non-option. Try again.".red
  end
end

