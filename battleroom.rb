#!/usr/bin/env ruby

require_relative './question_data/variable_questions'
require_relative './question_data/data_structure_questions'
require_relative './lib/battleroom_machinery'
include BattleroomMachinery
require 'colorize'
require 'pry'

clear_display
print "Welcome to the Battleroom.".blue
while true
  print_prompt_with_options
  choice = gets.chomp.downcase
  clear_display

  # for eval
  b = binding

  case choice
  when "1"
    10.times do
      question = VARIABLE_QUESTIONS.sample
      var_name = question[:var_name].sample
      var_value = question[:var_value].sample
      puts "Create a variable, #{var_name}, and assign it the #{question[:value_type]} value #{var_value}".blue
      answered_correctly = false
      until answered_correctly
        answer = gets.chomp
        begin
          b.eval(answer)
          if b.eval("#{var_name} == #{var_value}")
            answered_correctly = true
            puts random_congratulation.green
          else
            print "You mis-assigned #{var_name}. ".red + "Try Again!\n".green
          end
        rescue NameError
          print "Looks like you misnamed your variable. Often this will result in an error that says: \n\n".red
          print "\tundefined local variable or method \'WHATEVER_YOU_MISTYPED\'\n\n".green
          puts "Try again.".red
        rescue Exception => e
          puts e.message
        end
      end
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
      # data_structure_binding = binding
      # provides the binding scope with the variable assignment necessary for future
      b.eval("#{question[:variable_name]} = #{question[:data_structure].to_s}")
      puts "Given the data structure below, how would you access '#{answer_value}'?".blue
      puts  "#{question[:variable_name]} = #{question[:data_structure].to_s}".green
      answered_correctly = false
      until answered_correctly
        input = gets.chomp
        begin
          if b.eval(input) == answer_value
            puts random_congratulation.green
            answered_correctly = true
            sleep 1.5
            clear_display
          else
            puts "Wrong. Remember, #{hint} Try again.".red
          end
        rescue NameError
          puts "You're referencing a variable that doesn't exist, probably as the result of a mispelling. This results in a common error that says: \n\n".red
          puts "\tundefined local variable or method \'WHATEVER_YOU_MISTYPED\'\n".green
          puts "Get used to it and try again.".red
        end
      end
    end
  when "q"
    puts "Goodbye!".green
    break
  else
    puts "You entered a non-option. Try again.".red
  end
end

