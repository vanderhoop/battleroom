require_relative './follow_up_question'

class VariableReferenceQuestion < FollowUpQuestion

  def initialize(scope, original_question)
    super(scope, original_question)
  end

  def print_variable_reference_prompt
    # formatted_class = format_class_for_output(original_question.variable_value.class)
    # battleprint "The variable ".blue + original_question.variable_name.yellow + " now holds a reference to the #{formatted_class} value ".blue + original_question.formatted_value.yellow + "\n"
    battleprint "You now have the variable assignment below at your disposal.\n".blue
    # I want to print an indented, syntax highlighted variable assignment
    battleprint "\t" + original_question.variable_name.green + " = " + "#{original_question.formatted_value}\n"
    prompt = develop_prompt
    battleprint ""
  end

  def develop_prompt
    prompt = case original_question.variable_value.class
             when String
             when Fixnum
             when Symbol
             when Float
             when TrueClass, FalseClass
             end
  end

end
