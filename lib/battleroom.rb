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
      question = DATA_STRUCTURE_QUESTIONS.sample
      data_structure = question[:data_structure]
      if data_structure.class == Array
        answer_value = data_structure.sample
        hint = "index values start at 0."
      else
        answer_value = data_structure[data_structure.keys.sample]
        hint = "you have to use the EXACT hash key to retrieve the associated value."
      end
      answer_value = data_structure.class == Array ? data_structure.sample : data_structure[data_structure.keys.sample]
      # provides the binding scope with the variable assignment necessary for future
      b.eval("#{question[:variable_name]} = #{question[:data_structure].to_s}")
      puts "Given the data structure below, how would you access '#{answer_value}'?".blue
      puts  "#{question[:variable_name]} = #{question[:data_structure].to_s}".green
      answered_correctly = false
      until answered_correctly
        input = gets.chomp
        begin
          if b.eval(input) == answer_value
            print_congratulation
            answered_correctly = true
            sleep 1.5
            clear_display
          else
            puts "Wrong. Remember, #{hint} Try again.".red
          end
        rescue NameError
          print_colorized_name_error_prompt
        end
      end
    end
  when /^(q|exit\s?)/i
    puts "Goodbye!".green
    break
  else
    puts "You entered a non-option. Try again.".red
  end
end

