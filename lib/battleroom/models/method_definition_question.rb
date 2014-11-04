require_relative '../data/method_questions'
require_relative './question'

class MethodDefinitionQuestion < Question

  attr_accessor :method_name, :arg_count, :spec, :eval_string, :eval_answer

  @questions = METHOD_QUESTONS.shuffle

  def initialize(scope)
    super(scope)
    @method_name = data[:method_name]
    @arg_count = data[:arg_count]
    @spec = data[:spec]
    @eval_string = data[:eval_string]
    @eval_answer = data[:eval_answer]
    @input_mechanism = 'pry'
  end

  def print_prompt
    puts [
      'Define a method called '.blue,
      method_name.yellow,
      ' that takes '.blue,
      arg_count.to_s.yellow,
      ' argument(s) and '.blue,
      spec.blue,
    ].join + "\n\n"
  end

  def handle_name_error_exceptions(user_submission, error)
    if !(user_submission.include?('def'))
      print_no_method_error_prompt
    else
      print_colorized_error_prompt(error)
    end
  end

  def handle_incorrect_method_definition
    if user_input.include?('puts')
      print_puts_explanation
    else
      puts 'When calling '.red + eval_string + ",  your method returned #{return_value || 'nil'}. It should have returned #{eval_answer}. Try again.".red
    end
  end

  def print_puts_explanation
    puts 'Your method returned nil because the last expression used the "puts" method. The puts method prints strings to the console, but '.red + returns.red.underline + ' nil.'.red
  end

  def print_no_method_error_prompt
    puts "\nYou're trying to invoke a method that doesn't exist, i.e. you haven't defined it yet. This results in a common Ruby error that reads: \n".red
    puts "\tundefined local variable or method \'WHATEVER_YOU_TRIED_TO_INVOKE\'\n".green
    puts "Remember, method definitions begin with the \"def\" keyword, and end with the \"end\" keyword.\n".red
  end

  def fresh_binding
    binding
  end

  def print_wrong_method_error
    puts "\nYou defined the wrong method, probably as the result of a mispelling. Try again.\n".red
  end

  def print_argument_error_prompt(e)
    e.message.match(/wrong number of arguments \((\d) for (\d)\)/)
    passed_arg_count = $1.to_i
    expected_arg_count = $2.to_i
    puts "Looks like you defined #{method_name} to take #{expected_arg_count} argument(s), when it should take #{arg_count}. Try again.".red
  end

  def clean_eval_scope_of_method_definition
    if evaluation_scope.eval "respond_to?(:#{method_name}, true)"
      evaluation_scope.eval 'Object.class_eval("remove_method :' + method_name + '")'
    end
  end

  def evaluate_method_definition_input
    while user_input != 'exit'
      user_input = get_input
      begin
        clean_eval_scope_of_method_definition
        evaluation_scope.eval(user_input)
        return_value = evaluation_scope.eval(eval_string)
        if (return_value == eval_answer)
          congratulation_sequence(2.5)
          break
        else
          handle_incorrect_method_definition
        end
      rescue ArgumentError => e
        print_argument_error_prompt(e)
      rescue NoMethodError => e
        print_wrong_method_error
      # rescue NameError => e
        # handle_name_error_exceptions(user_input, e)
      end
    end
  end

end
