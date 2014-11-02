require_relative './question'

class MethodDefinitionFollowUpQuestion < Question

  attr_accessor :original_question

  def initialize(evaluation_scope, question_to_follow_up_on)
    @evaluation_scope = evaluation_scope
    @original_question = question_to_follow_up_on
  end

  def print_method_invocation_prompt
    code = CodeRay.scan($input, :ruby)
    puts code.term
    puts "\nYou have the ".blue + original_question.method_name.yellow + " method (above) at your disposal. Call it such that it returns the value ".blue + original_question.eval_answer.to_s.yellow + "\n\n"
  end

  def evaluate_user_input
    enter_evaluation_loop do |user_input|
      return_from_eval = original_question.evaluation_scope.eval(user_input)
      if return_from_eval == original_question.eval_answer
        true
      else
        puts "Remember, to call a method, you simply enter its name followed by any arguments it might need. Try again.".red
      end
    end
  end

end
