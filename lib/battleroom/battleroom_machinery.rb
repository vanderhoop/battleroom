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

  def evaluate_variable_assignment(evaluation_scope)
    answered_correctly = false
    until answered_correctly
      answer = gets.chomp
      abort("Goodbye!".green) if answer.match /^exit\s?/i
      begin
        evaluation_scope.eval(answer)
        if evaluation_scope.eval("#{@var_name} == #{@var_value}")
          print_congratulation
          answered_correctly = true
        else
          print "You mis-assigned #{var_name}. ".red + "Try Again!\n".green
        end
      rescue NameError
        puts "Looks like you mistyped the variable name. Check for misspellings and try again.".red
      rescue Exception => e
        puts e.message
      end
    end
  end

  def format_question_hash_based_on_data_structure_class(randomly_assigned_question)
    data_structure = randomly_assigned_question[:data_structure]
    if data_structure.class == Array
      randomly_assigned_question[:answer_value] = data_structure.sample
      randomly_assigned_question[:hint] = "index values start at 0."
    else
      randomly_assigned_question[:answer_value] = data_structure[data_structure.keys.sample]
      randomly_assigned_question[:hint] = "you have to use the EXACT hash key to retrieve the associated value."
    end
    randomly_assigned_question
  end

  def print_data_structure_access_prompt(given_question)
    puts "Given the data structure below, how would you access '#{given_question[:answer_value]}'?".blue
    puts "#{given_question[:variable_name]} = #{given_question[:data_structure].to_s}".green
  end

  def evaluate_data_structure_access_response(evaluation_scope)
    question_hash = DATA_STRUCTURE_QUESTIONS.sample
    question_hash = format_question_hash_based_on_data_structure_class(question_hash)
    # provides the binding scope with the variable assignment necessary for future
    evaluation_scope.eval("#{question_hash[:variable_name]} = #{question_hash[:data_structure].to_s}")
    print_data_structure_access_prompt(question_hash)
    answered_correctly = false
    until answered_correctly
      input = gets.chomp
      break if input === /^exit\s?/i
      begin
        if evaluation_scope.eval(input) == question_hash[:answer_value]
          print_congratulation
          answered_correctly = true
          sleep 1.5
          clear_display
        else
          puts "Wrong. Remember, #{question_hash[:hint]} Try again.".red
        end
      rescue NameError
        print_colorized_name_error_prompt
      end
    end
  end

end
