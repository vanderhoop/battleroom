require_relative 'question'
require_relative '../question_data/variable_assignment'

class VariableQuestion < Question
    # using a class instance variable, as manipulating a single class variable in the parent class is troublesome
    @questions = VARIABLE_QUESTIONS.shuffle

    def initialize
      super
      @variable_value = data[:possible_variable_values].sample
      @value_type = data[:value_type]
    end

    def print_variable_assignment_prompt
      puts "Create a variable, #{self.variable_name}, and assign it the #{self.value_type} value #{self.variable_value}".blue
    end

    def evaluate_variable_assignment_input(evaluation_scope)
      enter_evaluation_loop do |user_input|
        begin
          evaluation_scope.eval(user_input)
          if evaluation_scope.eval("#{self.variable_name} == #{self.variable_value}")
            # this last returned value of 'true' within is vital, as within the enter_evaluation_loop method, the return value of yield is used as a conditional.
            true
          else
            print "You mis-assigned #{self.variable_name}. ".red + "Try Again!\n".green
          end
        rescue NameError
          puts "Looks like you mistyped the variable name. Check for misspellings and try again.".red
        rescue Exception => e
          puts e.message
        end
      end
    end
  end # VariableQuestion
