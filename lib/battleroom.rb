#!/usr/bin/env ruby

require_relative 'battleroom/battleroom_machinery'
include BattleroomMachinery

clear_display
print "Welcome to the Battleroom.".blue
while true
  print_menu_options
  print "> ".blue
  choice = Readline.readline("", true)
  clear_display

  # for eval
  b = binding

  case choice
  when "1"
    10.times do
      q = Question.new(:variable, VARIABLE_QUESTIONS.sample)
      q.print_variable_assignment_prompt
      q.evaluate_variable_assignment_input(b)
    end
  when "2"
    5.times do
      q = Question.new(:data_structure_access, DATA_STRUCTURE_ACCESS_QUESTIONS.sample)
      q.print_data_structure_access_prompt
      q.evaluate_data_structure_access_input(b)
    end
  when "3"
    5.times do
      q = Question.new(:nested_data_structure_access, NESTED_DATA_STRUCTURE_ACCESS_QUESTIONS.sample)
      q.print_data_structure_access_prompt
      q.evaluate_data_structure_access_input(b)
    end
  when /^(q|exit\s?)/i
    puts "Goodbye!".green
    break
  else
    puts "You entered a non-option. Try again.".red
  end
end

