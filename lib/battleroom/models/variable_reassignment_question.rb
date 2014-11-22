require_relative 'follow_up_question'

class VariableReassignmentQuestion < FollowUpQuestion

  attr_accessor :toggled_boolean

  def initialize(evaluation_scope, original_question)
    super(evaluation_scope, original_question)
    @toggled_boolean = !(original_question.variable_value)
  end

  def print_variable_reassignment_prompt
    battleprint "Times have changed! Reassign ".blue + original_question.variable_name.yellow + " to the Boolean value ".blue + toggled_boolean.to_s.yellow + ".\n".blue
  end

  def evaluate_variable_reassignment_input
    enter_evaluation_loop do |user_submission|
      input = user_submission.chomp
      evaluation_scope.eval(input)
      if (evaluation_scope.eval(original_question.variable_name) == toggled_boolean)
        true
      else
        battleprint "Nope. Try again.".red
      end
    end
  end
end
