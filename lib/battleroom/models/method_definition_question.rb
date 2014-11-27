require_relative '../data/method_questions'
require_relative './question'

class MethodDefinitionQuestion < Question

  attr_accessor :method_name, :arg_count, :spec, :eval_string, :eval_answer,
                :return_value, :user_answer_verified

  @questions = METHOD_QUESTONS.shuffle

  def initialize(scope)
    super(scope)
    @method_name = data[:method_name]
    @arg_count = data[:arg_count]
    @spec = data[:spec]
    @eval_string = data[:eval_string]
    @eval_answer = data[:eval_answer]
    @input_mechanism = 'pry'
    print_prompt
    evaluate_method_definition_input
  end

  def print_prompt
    battleprint('Define a method called '.blue + method_name.yellow +  ' that takes '.blue + arg_count.to_s.yellow + " argument(s) and #{spec}.\n".blue)
  end

  def handle_name_error_exceptions(error, user_submission)
    if user_submission.include?('def') == false
      print_no_method_error_prompt
    else
      print_colorized_error_prompt(error)
    end
  end

  def handle_incorrect_method_definition(return_value)
    battleprint "\nWhen calling ".red + eval_string + ",  your method returned #{return_value || 'nil'}. It should have returned #{eval_answer}. Try again.\n".red
  end

  def print_puts_explanation
    battleprint 'The last line of your method definition uses Ruby\'s "puts" method. The "puts" method is helpful for logging errors and statuses to the console, but its actual '.red + "return".red.underline + " value is always nil, and thus your method returns nil. Try again, this time without using \"puts\".\n".red
  end

  def print_no_method_error_prompt
    battleprint "\nYou just trigged a common Ruby error that reads: \n".red
    battleprint "\tundefined method \'WHATEVER_METHOD_YOU_TRIED_TO_INVOKE\'\n".green
    battleprint "Basically, you tried to use a method before you defined it, and Ruby said, \"You haven't told me how to do that yet.\" To let Ruby know that you're defining a method, you'll use the the \"def\" keyword followed by the desired method name and an optional list of arguments between parentheses. Once you've finished writing the method's inner code, you'll let Ruby know that your method definition is finished by using the \"end\" keyword.\n".red
  end

  def fresh_binding
    binding
  end

  def print_wrong_method_error(error, user_submission)
    definition_pattern = Regexp.new("def\s*#{method_name}")
    if user_submission.match(definition_pattern)
      handle_incorrect_method_definition(user_submission)
    else
      battleprint "You defined the wrong method, probably as the result of a mispelling. Try again.".red
    end
  end

  def print_argument_error_prompt(e)
    e.message.match(/wrong number of arguments \((\d) for (\d)\)/)
    passed_arg_count = $1.to_i
    expected_arg_count = $2.to_i
    battleprint "\nLooks like you defined #{method_name} to take #{expected_arg_count} argument(s), when it should take #{arg_count}. Try again.\n".red
  end

  def clean_eval_scope_of_method_definition
    if evaluation_scope.eval "respond_to?(:#{method_name}, true)"
      evaluation_scope.eval 'Object.class_eval("remove_method :' + method_name + '")'
    end
  end

  def evaluate_method_definition_input
    enter_evaluation_loop do |user_submission|
      begin
        clean_eval_scope_of_method_definition
        # I want to make sure that the user's method isn't invoked if it uses the puts method
        if user_submission.include?('puts')
          print_puts_explanation
        else
          evaluation_scope.eval(user_submission)
          return_value = evaluation_scope.eval(eval_string)
          if (return_value == eval_answer)
            self.user_answer_verified = user_submission
            true
          else
            handle_incorrect_method_definition(return_value)
          end
        end
      rescue ArgumentError => e
        print_argument_error_prompt(e)
      rescue NoMethodError => e
        print_wrong_method_error(e, user_submission)
      rescue NameError => e
        handle_name_error_exceptions(e, user_submission)
      end
    end
  end

end
