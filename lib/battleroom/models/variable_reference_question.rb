require_relative './follow_up_question'

class VariableReferenceQuestion < FollowUpQuestion

  def initialize(scope, original_question)
    super(scope, original_question)
  end

  def print_variable_reference_prompt
    battleprint "The variable #{original_question.variable_name.green}".blue
  end

end
