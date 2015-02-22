require_relative 'question_printer'

class VariableAssignmentPrinter < QuestionPrinter

  def print_prompt(variable_name, variable_value, formatted_value)
    formatted_class = format_class_for_output(variable_value.class)
    battleprint('Assign the variable '.blue + variable_name.yellow + ' to the '.blue + formatted_class.blue + ' value '.blue + formatted_value.yellow + ".\n".blue)
  end

end
