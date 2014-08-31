#!/usr/bin/env ruby

require_relative 'battleroom/battleroom_machinery'
include BattleroomMachinery

 q = Question.new(VARIABLE_QUESTIONS.sample, :variable)
 q.format!

clear_display
print "Welcome to the Battleroom.".blue
while true
  print_menu_options
  choice = Readline.readline(">", true)
  clear_display

  # for eval
  b = binding

  case choice
  when "1"
    10.times do
      q = Question.new(VARIABLE_QUESTIONS.sample, :variable)
      q.provide_variable_prompt
      q.evaluate_variable_assignment(b)
    end
  when "2"
    5.times do
      data_structure_question = Question.new(DATA_STRUCTURE_ACCESS_QUESTIONS.sample, :data_structure_access)
      question_hash = format_question_hash_based_on_data_structure_class(question_hash)
      print_data_structure_access_prompt(question_hash)
      evaluate_data_structure_access_response(b, question_hash)
    end
  when /^(q|exit\s?)/i
    puts "Goodbye!".green
    break
  else
    puts "You entered a non-option. Try again.".red
  end
end

