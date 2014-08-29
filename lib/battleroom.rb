#!/usr/bin/env ruby

require_relative 'battleroom/battleroom_machinery'
include BattleroomMachinery

clear_display
print "Welcome to the Battleroom.".blue
while true
  print_menu_options
  choice = gets.chomp.downcase
  clear_display

  # for eval
  b = binding

  case choice
  when "1"
    10.times do
      provide_variable_prompt
      evaluate_variable_assignment(b)
    end
  when "2"
    5.times do
      evaluate_data_structure_access_response(b)
    end
  when /^(q|exit\s?)/i
    puts "Goodbye!".green
    break
  else
    puts "You entered a non-option. Try again.".red
  end
end

