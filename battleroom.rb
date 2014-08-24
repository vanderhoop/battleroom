!# /Users/vanderhoop/.rbenv/shims/ruby

require_relative './question_data/variable_questions'
require_relative './question_data/data_structure_questions'
require 'pry'
require 'colorize'

print "Welcome to the Battleroom. ".blue
while true
  print "What would you like to work on?\n".blue

  puts "1. Variable assignment"
  puts "2. Accessing values from arrays/hashes"
  puts "Q. Quit\r\n\n"

  choice = gets.chomp.downcase

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
            puts "Great job!".green
          else
            print "You mis-assigned #{var_name}. ".red + "Try Again!\n".green
          end
        rescue NameError
          puts "Looks like you misnamed your variable. Try again.".red
        rescue Exception => e
          puts e.message
        end
      end
    end
  when "2"
    2.times do
      question = DATA_STRUCTURE_QUESTIONS.sample
      answer_value = question[:data_structure].sample
      data_structure_binding = binding
      # provides the binding scope with the variable assignment necessary for future
      data_structure_binding.eval("#{question[:variable_name]} = #{question[:data_structure].to_s}")
      puts "Given the data structure below, how would you access '#{answer_value}'?".red
      puts  "#{question[:variable_name]} = #{question[:data_structure].to_s}".green
      answered_correctly = false
      until answered_correctly
        input = gets.chomp
        if data_structure_binding.eval(input) == answer_value
          puts "Lovely work, my friend!\n".green
          answered_correctly = true
        else
          puts "Close, but no cigar. Try again.\n"
        end
      end
    end
  when "q"
    puts "Goodbye!".green
    break
  else
    `reset`
    puts "You entered a non-option. Try again.".red
  end
end

