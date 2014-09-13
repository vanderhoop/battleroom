require_relative 'question'
require_relative '../question_data/variable_assignment'

class VariableQuestion < Question
    # using a class instance variable, as manipulating a single class variable in the parent class is troublesome
    @questions = VARIABLE_QUESTIONS.shuffle

    def initialize
      super
      @variable_value = rotate_array(data[:possible_variable_values]).first
    end

    def print_variable_assignment_prompt
      puts "Create a variable ".blue + self.variable_name.yellow + " and assign it the #{format_class_for_output(self.variable_value.class)} value ".blue + "#{format_value_for_stdout_and_eval(self.variable_value)}".yellow + ".".blue
    end

    def evaluate_variable_assignment_input(evaluation_scope)
      enter_evaluation_loop do |user_input|
        begin
          evaluation_scope.eval(user_input)
          formatted_value = format_value_for_stdout_and_eval(self.variable_value)
          if evaluation_scope.eval("#{self.variable_name} == #{formatted_value}")
            # this last returned value of 'true' within is vital, as within the enter_evaluation_loop method, the return value of yield is used as a conditional.
            true
          else
            puts "You mis-assigned #{self.variable_name}. Try again!".red
          end
        rescue NameError
          if !user_input.match /("|')/
            puts "Rats! You've just made a common rookie mistake! Strings are always surrounded by quotes. Otherwise, Ruby will think you're referencing a variable or method name. Try again.".red
          else
            puts "Looks like you mistyped the variable name. Check for misspellings and try again.".red
          end
        rescue Exception => e
          # binding.pry
          if !user_input.match /("|')/
            puts "Rats! You've just made a common rookie mistake! Strings are always surrounded by quotes. Otherwise, Ruby will think you're referencing a variable or method name. Try again.".red
          elsif e.message.match /unterminated string/
            puts "Blurg! You neglected to provide closing quotes for your string. Try again!".red
          else
            puts e.message
          end
        end
      end
    end
  end # VariableQuestion
