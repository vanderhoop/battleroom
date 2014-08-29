require_relative 'question_data/variable_assignment'
require_relative 'question_data/data_structure_access'
require 'pry'
require 'colorize'

module BattleroomMachinery

  def clear_display
    `reset`
  end

  def print_menu_options
    puts "What would you like to work on?".blue
    puts "1. Variable assignment"
    puts "2. Accessing values from arrays/hashes"
    puts "Q. Quit\r\n\n"
  end

  def random_congratulation
    ["Lovely work, my friend!\n", "Beautiful!\n", "Lovely!\n", "Splendid!\n", "Nice job! Keep it rolling!\n", "Capital work, battlestar!\n", "You're on your way!\n", "Exemplary work!\n", "Yeah!\n", "Roll on.\n", "You're making a prosperous go of this programming thing.\n", "Bullseye!\n"].sample
  end

  def print_congratulation
    puts random_congratulation.green
  end

  def provide_variable_prompt
    question = VARIABLE_QUESTIONS.sample
    @var_name = question[:var_name].sample
    @var_value = question[:var_value].sample
    puts "Create a variable, #{@var_name}, and assign it the #{question[:value_type]} value #{@var_value}".blue
  end

  def print_colorized_name_error_prompt
    puts "You're referencing a variable that doesn't exist, probably as the result of a mispelling. This results in a common error that says: \n\n".red
    puts "\tundefined local variable or method \'WHATEVER_YOU_MISTYPED\'\n".green
    puts "Get used to it and try again.".red
  end

end
