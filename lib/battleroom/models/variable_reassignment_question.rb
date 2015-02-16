require_relative 'follow_up_question'

class VariableReassignmentQuestion < FollowUpQuestion

  attr_accessor :toggled_boolean

  def post_initialize
    @toggled_boolean = !(original_question.variable_value)
    print_variable_reassignment_prompt
    evaluate_variable_reassignment_input
  end

  def print_variable_reassignment_prompt
    battleprint "Times have changed! Reassign ".blue + original_question.variable_name.yellow + " to the Boolean value ".blue + toggled_boolean.to_s.yellow + ".\n".blue
  end

  def evaluate_variable_reassignment_input
    enter_evaluation_loop do
      begin
        evaluation_scope.eval(user_input)
        if (evaluation_scope.eval(original_question.variable_name) == toggled_boolean)
          true
        else
          battleprint "Nope. Try again.".red
        end
      rescue NameError, NoMethodError => e
        print_colorized_error_prompt(e)
      end
    end
  end
end
