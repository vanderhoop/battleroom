require_relative 'helpers/printable'

module BattleroomMachinery
  include Battleroom::Printable

  def clear_display
    `reset`
  end

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

  def naughty_input?(user_input)
    if user_input.match(/(require|`|binding)/)
      battleprint "No way no how! Try again.\n".red
      true
    else
      false
    end
  end

end
