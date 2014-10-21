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
  end

  def print_prompt
    puts [
      "Define a method, ".blue,
      method_name.green,
      ", that takes ".blue,
      arg_count.to_s.green,
      " argument(s) and ".blue,
      spec.blue,
    ].join + "\n\n"
  end

  def print_no_method_error_prompt
    puts "\nYou're trying to invoke a method that doesn't exist, i.e. you haven't defined it yet. This results in a common Ruby error that reads: \n".red
    puts "\tundefined local variable or method \'WHATEVER_METHOD_YOU_TRIED_TO_INVOKE\'\n".green
    puts "Remember, method definitions begin with the 'def' keyword, and end with the 'end' keyword.\n".red
  end

  def fresh_binding
    binding
  end

  def print_wrong_method_error
    puts "\nYou defined the wrong method, probably as the result of a mispelling. Try again.\n".red
  end

  def print_argument_error_prompt
    e.message.match(/wrong number of arguments \((\d) for (\d)\)/)
    passed_arg_count = $1.to_i
    expected_arg_count = $2.to_i
    puts "Looks like you defined #{method_name} to take #{expected_arg_count} argument(s), when it should take #{arg_count}. Try again.".red
  end

  def evaluate_method_definition_input
    method_count = Object.new.methods.length
    user_input = ""
    while user_input != "exit"
      Pry.start_without_pry_debugger(evaluation_scope)
      user_input = $input
      begin
        fresh_binding.eval(user_input)
        return_value = fresh_binding.eval(eval_string)
        Object.class_eval("remove_method :#{method_name}") if Object.new.methods.include?(method_name.to_sym)
        if (return_value == eval_answer)
          congratulation_sequence
          break
        else
          puts "When calling ".red + eval_string + ",  your method returned #{return_value || "nil"}. It should have returned #{eval_answer}. Try again.".red
        end
      rescue ArgumentError => e
        print_argument_error_prompt
      rescue NoMethodError => e
        print_wrong_method_error
      rescue NameError => e
        print_colorized_error_prompt(e)
      end
    end
  end

end
