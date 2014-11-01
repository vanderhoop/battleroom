require_relative './question'

class MethodDefinitionFollowUpQuestion < Question

  attr_accessor :original_question

  def initialize(evaluation_scope, question_to_follow_up_on)
    super(evaluation_scope)
    @original_question = question_to_follow_up_on
  end

  def print_method_invocation_prompt
    puts "You now have a method, " + original_question.method_name
    puts $user_input
    binding.pry
  end

  def evaluate_user_input
  end

end

# I want to test this after several methods have been successfully defined.
