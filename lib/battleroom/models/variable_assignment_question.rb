require_relative 'question'
require_relative '../data/variable_assignment_questions'

class VariableAssignmentQuestion < Question

  attr_accessor :formatted_value, :formatted_class
  @questions = VARIABLE_QUESTIONS.shuffle

  def post_initialize
    @variable_value = rotate_array(data[:possible_variable_values]).first
    @formatted_value = format_value_for_stdout_and_eval(variable_value)
    print_variable_assignment_prompt
    evaluate_variable_assignment_input
  end

  def print_variable_assignment_prompt
    self.formatted_class = format_class_for_output(variable_value.class)
    substrings = [
      'Assign the variable '.blue,
      variable_name.yellow,
      ' to the '.blue,
      formatted_class.blue,
      ' value '.blue,
      formatted_value.yellow,
      ".\n".blue
    ]
    battleprint substrings.join
  end

  def reveal_name_error_follies_to_user
    if user_input.include?(variable_name)
      if !user_input.match(/[^=]=[^=]/i)
        undefined_local_variable_prompt_for_correct_variable
      else
        misassignment_prompt
      end
    elsif !user_input.match(/("|')/) && variable_value.class == String
      battleprint 'Rats! You\'ve just made a common rookie mistake! Strings are always surrounded by quotes. Otherwise, Ruby will think you\'re referencing a variable or method name. Try again.'.red
    else
      battleprint "Looks like you mistyped the variable name. Check for misspellings and try again.".red
    end
  end

  def undefined_local_variable_prompt_for_correct_variable
    battleprint "\nYou're referencing a variable that hasn't been assigned yet. This results in a common error that says: \n".red
    battleprint "\tundefined local variable or method \'#{variable_name}\'\n".green
    battleprint "To assign a value to a variable, you'll need to use the assignment operator ".red + ' = '.black.on_light_white + ", followed by a valid Ruby value.\n".red
  end

  def handle_base_exception(exception)
    if exception.message.match(/unterminated string/)
      battleprint 'Blurg! You neglected to provide closing quotes for your string. Try again!'.red
    else
      battleprint exception.message
    end
  end

  def evaluate_variable_assignment_input
    enter_evaluation_loop do
      begin
        evaluation_scope.eval(user_input)
        if evaluation_scope.eval("#{variable_name} == #{formatted_value}")
          true
        else
          battleprint "You assigned the wrong value to #{variable_name}. Try again!".red
        end
      rescue NameError => e
        reveal_name_error_follies_to_user
      rescue Exception => e
        handle_base_exception(e)
      end
    end
  end
end # VariableQuestion
