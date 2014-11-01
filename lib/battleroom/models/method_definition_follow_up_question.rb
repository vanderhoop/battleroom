require_relative './question'

class MethodDefinitionFollowUpQuestion < Question

  attr_accessor :original_question

  def initialize(evaluation_scope, question_to_follow_up_on)
    @evaluation_scope = evaluation_scope
    @original_question = question_to_follow_up_on
  end

  def print_method_invocation_prompt
    evaluation_scope.eval("show-method(#{original_question.method_name})")
    ap($input, { multiline: true })
    puts "You now have the above method at your disposal. Next, call the method such that it returns the value ".blue + original_question.correct_answer.yellow
    puts ''
  end

  def evaluate_user_input
    binding.pry
  end

end

# I want to test this after several methods have been successfully defined.
