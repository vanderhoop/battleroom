require_relative './question'

class MethodDefinitionFollowUpQuestion < Question

  attr_reader   :original_question, :desired_answer_formatted, :desired_answer_class_formatted

  def initialize(evaluation_scope, question_to_follow_up_on)
    @evaluation_scope = evaluation_scope
    @original_question = question_to_follow_up_on
    @desired_answer_formatted = format_value_for_stdout_and_eval(original_question.eval_answer)
    @desired_answer_class_formatted = format_class_for_output(original_question.eval_answer.class)
  end

  def format_method_definition_for_stdout
    code = CodeRay.scan($input, :ruby)
    # adds indentation to all lines of method definition
    code.term.gsub(/^.*/) { |match| "\t" + match }
  end

  def print_method_invocation_prompt
    puts "You now have the method defined below at your disposal.\n".blue
    puts format_method_definition_for_stdout
    puts "\nCall ".blue + original_question.method_name.yellow + " such that it returns the ".blue + desired_answer_class_formatted.blue + " value ".blue + desired_answer_formatted.yellow + "\n\n"
  end

  def evaluate_user_input
    enter_evaluation_loop do |user_input|
      return_from_eval = original_question.evaluation_scope.eval(user_input)
      if return_from_eval == original_question.eval_answer
        puts ''
        true
      else
        puts "Remember, to call a method, you simply enter its name followed by any arguments it might need. Try again.".red
      end
    end
  end

end
