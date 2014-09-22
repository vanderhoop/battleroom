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
    puts "2. Accessing values in arrays and hashes"
    puts "3. Adding values to arrays and hashes"
    puts "4. Accessing values from within nested data structures"
    puts "Q. Quit\r\n\n"
  end

  def random_congratulation
    ["Lovely work, my friend!", "Beautiful!", "Lovely!", "Splendid!", "Nice job! Keep it rolling!", "Capital work, battlestar!", "You're on your way!", "Exemplary work!", "Yeah!", "Roll on.", "You're making a prosperous go of this programming thing.", "Bullseye!", "Woo!", "Let it ride!", "Touchdown!"].sample
  end

  def print_congratulation
    puts "#{random_congratulation}\n".green
  end

  def rotate_array(array)
    item = array.shift
    array << item
  end

  def print_colorized_error_prompt(error)
    method_or_variable = (error.class == NoMethodError) ? "method" : "variable"
    puts "\nYou're referencing a #{method_or_variable} that doesn't exist, probably as the result of a mispelling. This results in a common error that says: \n".red
    puts "\tundefined local variable or method \'WHATEVER_YOU_MISTYPED\'\n".green
    puts "Get used to it and try again.\n".red
  end

  def print_colorized_type_error_prompt(error)
    puts "\nNope! You just triggered a common Ruby error that reads:\n".red
    puts "\tin '[]', #{error.message}".green
    error.message.match /conversion\sof\s(.+)\sinto\sInteger/i
    puts "\nBasically, you put a #{$1} between square brackets, whereas Ruby
            was expecting an index value, i.e. an integer. This commonly arises
            when programmers think they're dealing with a hash, when in fact
             they're dealing with an array.\n".red
  end

  def format_value_for_stdout_and_eval(object)
    case object.class.to_s
    when "String" then return "'#{object}'"
    when "Symbol" then return ":#{object}"
    else
      object.to_s
    end
  end

  def format_class_for_output(klass)
    return "Boolean" if klass.to_s.match /(TrueClass|FalseClass)/
    klass.to_s
  end

end
