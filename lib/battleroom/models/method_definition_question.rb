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
    ].join
  end

  def evaluate_method_definition_input(user_input)
    enter_evaluation_loop do |user_input|
      answer = ""
      if user_input.match(/\Adef\s/)
        binding.pry
        # this means that the user entered one line correctly.
        # I want to let them keep entering code until they enter "end",
        # so more readline with an * character prepended?
        answer += user_input + "\n"
        while user_input != "end"
          user_input = Readline.readline("* ".blue)
          answer += user_input + "\n"
        end
        evaluation_scope.eval(answer)
      end


      # begin
      # rescue SyntaxError => e
        # if e.message.match(/unexpected end-of-input, expecting ';' or '\\n'/)

        # end
      # end
    end
  end

end
