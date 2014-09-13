require 'awesome_print'
require 'pry'
require 'colorize'

module BattleroomMachinery

  def clear_display
    `reset`
  end

  def print_menu_options
    puts " What would you like to work on?".blue
    puts "1. Variable assignment"
    puts "2. Accessing values from arrays/hashes"
    puts "3. Accessing values from within nested data structures"
    puts "Q. Quit\r\n\n"
  end

  def random_congratulation
    ["Lovely work, my friend!", "Beautiful!", "Lovely!", "Splendid!", "Nice job! Keep it rolling!", "Capital work, battlestar!", "You're on your way!", "Exemplary work!", "Yeah!", "Roll on.", "You're making a prosperous go of this programming thing.", "Bullseye!", "Woo!", "Let it ride!", "Touchdown!"].sample
  end

  def print_congratulation
    puts "#{random_congratulation}\n".green
  end

  def print_colorized_name_error_prompt(error)
    puts "You're referencing a variable that doesn't exist, probably as the result of a mispelling. This results in a common error that says: \n".red
    puts "\tundefined local variable or method \'WHATEVER_YOU_MISTYPED\'\n".green
    puts "Get used to it and try again.".red
  end

  def format_value_for_stdout_and_eval(object)
    case object.class.to_s
    when "String" then return "'#{object}'"
    when "Symbol" then return ":#{object}"
    else
      object
    end
  end

  def format_class_for_output(klass)
    return "Boolean" if klass.to_s.match /(TrueClass|FalseClass)/
    klass.to_s
  end

end
