require_relative './follow_up_question'

class MethodInvocationQuestion < FollowUpQuestion

  attr_reader   :original_question, :desired_answer_formatted,
                :desired_answer_class_formatted

  def initialize(evaluation_scope, question_to_follow_up_on)
    @evaluation_scope = evaluation_scope
    @original_question = question_to_follow_up_on
    @desired_answer_formatted = format_value_for_stdout_and_eval(original_question.eval_answer)
    @desired_answer_class_formatted = format_class_for_output(original_question.eval_answer.class)
  end

  def format_method_definition_for_stdout
    code = CodeRay.scan($input, :ruby)
    ansi_prepped_string = code.term
    indent_all_lines_for_stdout(ansi_prepped_string)
  end

  def print_method_invocation_prompt
    battleprint "You now have the method defined below at your disposal.\n".blue
    battleprint format_method_definition_for_stdout
    battleprint "\nInvoke the '#{original_question.method_name}' method such that it returns the ".blue + desired_answer_class_formatted.blue + " value ".blue + desired_answer_formatted.yellow + ".\n".blue
  end

  def print_no_method_error_prompt
    battleprint "\nYou just trigged a common Ruby error that reads: \n".red
    battleprint "\tundefined local variable or method \'WHATEVER_METHOD_YOU_TRIED_TO_INVOKE\'\n".green
    battleprint "Basically, you tried to invoke a method that doesn't exist. Try again.\n".red
  end

  def print_name_error_prompt(error, user_submission)
    battleprint "\nYou just triggered a common Ruby error that reads:\n".red
    battleprint "\tNameError: #{error.message}\n".green
    referenced_variable = isolate_variable_name_from_name_error(error)
    parameters = isolate_argument_names_from_method_def
    if parameters.find { |parameter| parameter == referenced_variable }
      battleprint "Looks like the variable you referenced was one of the argument names in your method #{'definition'.red.underline}. The arguments in method definitions are just placeholders for whatever values end up getting passed in when the method is called. Think on this for a moment before trying again.\n".red
    else
      battleprint "Basically, you're referencing a variable, \"#{referenced_variable}\", that hasn't been assigned a value.\n".red
    end
  end

  def isolate_variable_name_from_name_error(error)
    error.name.to_s
  end

  def print_argument_error_prompt(e)
    e.message.match(/wrong number of arguments \((\d) for (\d)\)/)
    passed_arg_count = $1.to_i
    expected_arg_count = $2.to_i
    battleprint "You just triggered a common Ruby error that reads:\n".red
    battleprint "\tArgumentError: #{e.message}\n".green
    battleprint "Basically, you defined the '#{original_question.method_name}' method to expect #{expected_arg_count} argument(s), and you're only passing it #{passed_arg_count}. Try again.\n".red
  end

  def isolate_argument_names_from_method_def
    isolate_parameter_list_string_from_method_def.scan(/([^,\s]+)+/x).flatten
  end

  def isolate_parameter_list_string_from_method_def
    original_question.user_answer_verified.match /\((.+)\)/
    $1
  end

  def evaluate_user_input
    enter_evaluation_loop do |user_submission|
      begin
        return_from_eval = original_question.evaluation_scope.eval(user_submission)
        if return_from_eval == original_question.eval_answer
          true
        else
          battleprint "\nRemember, to call a method, you simply enter its name followed by any arguments it might need. Try again.\n".red
        end
      rescue NoMethodError => e
        print_no_method_error_prompt
      rescue NameError => e
        print_name_error_prompt(e, user_submission)
      rescue ArgumentError => e
        print_argument_error_prompt(e)
      end
    end
  end

end
