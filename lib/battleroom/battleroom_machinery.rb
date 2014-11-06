module BattleroomMachinery

  CONGRATULATIONS = [
    'Lovely work, my friend!',
    'Beautiful!',
    'Lovely!',
    'Splendid!',
    'Nice job! Keep it rolling!',
    'Capital work, battlestar!',
    'Exemplary work!',
    'Yeah!',
    'Roll on.',
    'Bullseye!',
    'Woo!',
    'Let it ride!',
    'Touchdown!',
    "You're on your way!",
    "You're making a prosperous go of this programming thing.",
  ]

  def clear_display
    `reset`
  end

  def print_menu_options
    battleprint ' What would you like to work on?'.blue
    battleprint '1. Variable assignment'
    battleprint '2. Accessing values in arrays and hashes'
    battleprint '3. Adding values to arrays and hashes'
    battleprint '4. Accessing values from within nested data structures'
    battleprint '5. Defining methods'
    battleprint "Q. Quit\r\n\n"
  end

  def random_congratulation
    CONGRATULATIONS.sample
  end


  def print_congratulation
    battleprint "#{random_congratulation}\n".green
  end

  def rotate_array(array)
    item = array.shift
    array << item
  end

  def print_colorized_error_prompt(error)
    method_or_variable = (error.class == NoMethodError) ? "method" : "variable"
    battleprint "\nYou're referencing a #{method_or_variable} that doesn't exist, probably as the result of a mispelling. This results in a common error that says: \n".red
    battleprint "\tundefined local variable or method \'WHATEVER_YOU_MISTYPED\'\n".green
    battleprint "Get used to it and try again.\n".red
  end

  def indent_all_lines_for_stdout(string_to_indent)
    string_to_indent.gsub(/^.*/) { |match| "\t" + match }
  end

  def dynamic_word_wrap(string)
    string.wrap(150)
  end

  def battleprint(string)
    puts dynamic_word_wrap(string)
  end

  def window_width
    begin
      width_string = `tput cols`
    rescue StandardError => e # for cases where systems don't respond to the tput command
      width_string = "80"
    end
    width_string.strip.to_i
  end

  def print_unexpected_end_of_input_explanation
    battleprint "\nNope! You just triggered a common Ruby error that reads:\n".red
    battleprint "\tsyntax error, unexpected end-of-input\n".green
    battleprint "Basically, you told Ruby you were going to assign a value to a variable, but you neglected to provide a valid value. Try again.\n".red
  end

  def print_colorized_type_error_prompt(error)
    battleprint "\nNope! You just triggered a common Ruby error that reads:\n".red
    battleprint "\tin '[]', #{error.message}".green
    error.message.match /conversion\sof\s(.+)\sinto\sInteger/i
    battleprint "\nBasically, you put a #{$1} between square brackets, whereas Ruby ".red +
         "was expecting an index value, i.e. an integer. This commonly arises ".red +
         "when programmers think they're dealing with a hash, when in fact ".red +
         "they're dealing with an array. Try again.\n".red
  end

  def format_value_for_stdout_and_eval(object)
    case object.class.to_s
    when 'String'
      if object.include?("'")
        '"' + object + '"'
      else
        "'#{object}'"
      end
    when 'Symbol' then return ":#{object}"
    else
      object.to_s
    end
  end

  def naughty_input?(user_input)
    if user_input.match(/(require|`|binding)/)
      battleprint "No way no how! Try again.\n".red
      true
    else
      false
    end
  end

  def format_class_for_output(klass)
    return 'Boolean' if klass.to_s.match /(TrueClass|FalseClass)/
    klass.to_s
  end
end
