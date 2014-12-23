module BattleroomMachinery

  # CONGRATULATIONS = [
  #   'Lovely work, my friend!',
  #   'Beautiful!',
  #   'Lovely!',
  #   'Splendid!',
  #   'Awesome.',
  #   'Stand up job, my friend.',
  #   'Nailed it.',
  #   'Nice job! Keep it rolling!',
  #   'Capital work, battlestar!',
  #   'Exemplary work!',
  #   'Yeah!',
  #   'Roll on.',
  #   'Bullseye!',
  #   'Woo!',
  #   'Let it ride!',
  #   'Touchdown!',
  #   "You're on your way!",
  #   "You're making a prosperous go of this programming thing.",
  # ]

  def clear_display
    `reset`
  end

  # def print_menu_options
  #   battleprint ' What would you like to work on?'.blue
  #   battleprint '1. Working with Variables'
  #   battleprint '2. Accessing Values in Arrays and Hashes'
  #   battleprint '3. Adding Values to Arrays and Hashes'
  #   battleprint '4. Working with Methods'
  #   battleprint "Q. Quit\r\n\n"
  # end

  # def random_congratulation
  #   CONGRATULATIONS.sample
  # end


  # def print_congratulation
  #   battleprint "\n#{random_congratulation}\n".green
  # end

  def rotate_array(array)
    item = array.shift
    array << item
  end

  def print_colorized_error_prompt(error)
    method_or_variable = (error.class == NoMethodError) ? "method" : "variable"
    battleprint "\nYou're referencing a #{method_or_variable} that doesn't exist, probably as the result of a mispelling. This results in a common Ruby error that reads: \n".red
    battleprint "\tundefined local variable or method \'WHATEVER_YOU_MISTYPED\'\n".green
    battleprint "Get used to it and try again.\n".red
  end

  # def indent_all_lines_for_stdout(string_to_indent)
  #   string_to_indent.gsub(/^.*/) { |match| "\t" + match }
  # end

  # def dynamic_word_wrap(string)
  #   string.wrap(150)
  # end

  # def battleprint(string)
  #   puts dynamic_word_wrap(string)
  # end

  def isolate_variable_name_from_name_error(error)
    /`(.+)'/i.match(error.message)
  end

  def print_unexpected_end_of_input_explanation(error)
    battleprint "\nNope! You just triggered a common Ruby error that reads:\n".red
    battleprint "\tsyntax error, unexpected end-of-input\n".green
    if error.message.include?(']')
      battleprint "Basically, you used an opening square bracket '[', but didn't pair it with a closing square bracket. Try again.\n".red
    else
      battleprint "Basically, you told Ruby you were going to assign a value to a variable, but you neglected to provide a valid value. Try again.\n".red
    end
  end

  def determine_variable_follow_up_question(eval_scope, question)
    if question.variable_value == true || question.variable_value == false
      VariableReassignmentQuestion.new(eval_scope, question)
    elsif question.variable_value.class == Symbol || question.variable_value.class == String
      nil
    else
      VariableReferenceQuestion.new(eval_scope, question)
    end
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

  # def format_value_for_stdout_and_eval(object)
  #   case object.class.to_s
  #   when 'String'
  #     if object.include?("'")
  #       '"' + object + '"'
  #     else
  #       "'#{object}'"
  #     end
  #   when 'Symbol' then return ":#{object}"
  #   else
  #     object.to_s
  #   end
  # end

  def naughty_input?(user_input)
    if user_input.match(/(require|`|binding)/)
      battleprint "No way no how! Try again.\n".red
      true
    else
      false
    end
  end

  # def format_class_for_output(klass)
  #   return 'Boolean' if klass.to_s.match /(TrueClass|FalseClass)/
  #   klass.to_s
  # end

end
