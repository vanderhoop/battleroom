!# /Users/vanderhoop/.rbenv/shims/ruby

require_relative 'variable_questions'
require 'pry'
require 'colorize'

puts "Welcome to the Battleroom. What would you like to work on?".blue

puts "1. Variable assignment"
puts "2. Accessing values from arrays/hashes"

choice = gets.chomp.to_i

case choice
when 1

  5.times do
    question = VARIABLE_QUESTIONS.sample
    var_name = question[:var_name].sample
    var_value = question[:var_value].sample
    puts "Create a variable, #{var_name}, and assign it the #{question[:value_type]} value #{var_value}".blue
    answered_correctly = false
    until answered_correctly
      answer = gets.chomp
      begin
        eval(answer)
        b = binding
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
when 2
end

