require_relative './question'

class MethodDefinitionFollowUpQuestion < Question

  attr_accessor :original_question

  def initialize(evaluation_scope, question_to_follow_up_on)
    @evaluation_scope = evaluation_scope
    @original_question = question_to_follow_up_on
  end

  def print_method_invocation_prompt
    puts "You have the above method at your disposal. Now call the method such that it returns the value ".blue + original_question.eval_answer.to_s.yellow + "\n\n"
  end

  def evaluate_user_input
    enter_evaluation_loop do |user_input|
      return_from_eval = original_question.evaluation_scope.eval(user_input)
      if return_from_eval == original_question.eval_answer
        congratulation_sequence(1.6)
      else
        puts "Remember, to call a method, you simply enter its name followed by any arguments it might need. Try again.".red
      end
    end
  end

end
