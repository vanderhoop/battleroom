require_relative '../data/method_questions'
require_relative './question'

class MethodDefinitionQuestion < Question

  attr_accessor :method_name, :arg_count, :spec

  @questions = METHOD_QUESTONS.shuffle

  def initialize(scope)
    super(scope)
    @method_name = data[:method_name]
    @arg_count = data[:arg_count]
    @spec = data[:spec]
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

  def uses_def_keyword?(user_input)
    if user_input.match(/\Adef\s+/)
      true
    else
      puts "Method definitions start with the ".red + "def".green + " keyword, which signals to Ruby that you're defining a method.".red
      false
    end
  end

  def evaluate_method_definition_input(user_input)
    enter_evaluation_loop do |user_input|
      uses_def_keyword?(user_input)
      begin
        evaluation_scope.eval(user_input)
        # return_value = evaluation_scope.eval("#{method_name}(4,7)")
        # if (return_value == 28)
        #   true
        # else
        #   puts "When multiplying 4 and 7, your method returned #{return_value}. It should have returned 28. Try again.".red
        #   false
        # end
      rescue NameError => e
        puts e
      end
    end
  end

end
