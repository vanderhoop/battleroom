require_relative 'question'
require_relative '../data/variable_assignment_questions'

class VariableAssignmentQuestion < Question
  attr_accessor :formatted_value
  # using a class instance variable, as manipulating a single class var
  # in the parent class is troublesome
  @questions = VARIABLE_QUESTIONS.shuffle

  def initialize(eval_scope)
    super(eval_scope)
    @variable_value = rotate_array(data[:possible_variable_values]).first
    @formatted_value = format_value_for_stdout_and_eval(variable_value)
  end

  def print_variable_assignment_prompt
    formatted_class = format_class_for_output(variable_value.class)
    substrings = [
      'Create a variable '.blue,
      variable_name.yellow,
      ' and assign it the '.blue,
      formatted_class.blue,
      ' value '.blue,
      formatted_value.yellow,
      ".\n".blue
    ]
    battleprint substrings.join
  end

  def reveal_name_error_follies_to_user(user_input)
    if user_input.include?(variable_name) && !user_input.match(/[^=]=[^=]/i)
      battleprint 'You\'re not using the assignment operator!'.red
    elsif !user_input.match(/("|')/) && variable_value.class == String
      battleprint 'Rats! You\'ve just made a common rookie mistake! ' +
           'Strings are always surrounded by quotes. Otherwise, Ruby will ' +
           'think you\'re referencing a variable or method name. Try again.'.red
    else
      battleprint "Looks like you mistyped the variable name. Check for misspellings and try again.\n".red
    end
  end

  def evaluate_variable_assignment_input
    enter_evaluation_loop do |user_submission|
      begin
        evaluation_scope.eval(user_submission)
        if evaluation_scope.eval("#{variable_name} == #{formatted_value}")
          # this last returned value of 'true' is vital;
          # the return value of yield is used in a conditional
          true
        else
          battleprint "You mis-assigned #{variable_name}. Try again!".red
        end
      rescue NameError => e
        reveal_name_error_follies_to_user(user_submission)
      rescue Exception => e
        if e.message.match(/unterminated string/)
          battleprint 'Blurg! You neglected to provide closing quotes for your string. Try again!'.red
        else
          battleprint e.message
        end
      end
    end
  end
end # VariableQuestion
