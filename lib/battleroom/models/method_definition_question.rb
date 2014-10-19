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

  def evaluate_method_definition_input
    user_input = ""
    while user_input != "exit"
      Pry.start_without_pry_debugger(evaluation_scope)
      user_input = $input
      begin
        evaluation_scope.eval(user_input)
        return_value = evaluation_scope.eval(eval_string)
        Object.class_eval("remove_method :#{method_name}") if Object.new.methods.include?(method_name.to_sym)
        if (return_value == eval_answer)
          congratulation_sequence
          break
        else
          puts "When calling ".red + eval_string + ",  your method returned #{return_value || "nil"}. It should have returned #{eval_answer}. Try again.".red
        end
      rescue ArgumentError => e
        e.message.match(/wrong number of arguments \((\d) for (\d)\)/)
        passed_arg_count = $1.to_i
        expected_arg_count = $2.to_i
        puts "Looks like you defined #{method_name} to take #{expected_arg_count} argument(s), when it should take #{arg_count}. Try again.".red
      rescue NameError => e
        if (e.class == NoMethodError)
          method_or_variable = "method"
          assigned_or_defined = "defined"
          referencing_or_trying_to_invoke = "trying to invoke"
        else
          method_or_variable = "variable"
          assigned_or_defined = "assigned"
          referencing_or_trying_to_invoke = "referencing"
        end

        puts "\nYou're #{referencing_or_trying_to_invoke} a #{method_or_variable} that doesn't exist, i.e. you haven't #{assigned_or_defined} it. This results in a common Ruby error that reads: \n".red
        puts "\tundefined local variable or method \'WHATEVER_#{method_or_variable.upcase}_YOU_TRIED_TO_INVOKE\'\n".green
        puts "Remember, method definitions begin with the 'def' keyword, and end with the 'end' keyword.\n".red
      end
    end
  end

end
