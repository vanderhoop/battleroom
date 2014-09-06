require_relative 'question_data/variable_assignment'
require_relative 'question_data/data_structure_access'
require_relative 'question_data/nested_data_structure_access'
require 'awesome_print'
require 'pry'
require 'colorize'

module BattleroomMachinery
  class Question
    attr_reader :type, :data
    attr_accessor :variable_name, :variable_value, :value_type, :data_structure,
                  :hint, :data_structure_class, :answer_value, :inner_hash,
                  :inner_array, :explanation

    def initialize
      @data = self.class.generate_question
    end

    # calls on class instance variables set in the subclasses
    def self.generate_question
      question = @questions.shift
      @questions.push(question)
      question
    end

    def generate_data_structure_access_question
      @@data_structure_access_questions.shift
    end

    def generate_nested_data_structure_access_question
      @@nested_data_structure_access_questions.shift
    end

    def format!
      case self.type
      when :data_structure_access
        if data_structure.class == Array
          # randomizes and shuffles the items in the arrays, so repeats remain interesting
          self.data_structure = data_structure.shuffle[0,4]
          self.answer_value = data_structure.sample
          self.hint = "index values start at 0."
          self.data_structure_class = "Array"
        else
          self.answer_value = data_structure[data_structure.keys.sample]
          self.hint = "you have to use the EXACT hash key to retrieve the associated value."
          self.data_structure_class = "Hash"
        end
      when :nested_data_structure_access
        if data_structure.class == Array
          # randomizes and shuffles the items in the arrays, so repeats remain interesting
          self.data_structure = data_structure.shuffle[0,4]
          self.inner_hash = data_structure.sample
          self.answer_value = inner_hash[inner_hash.keys.sample]
          self.data_structure_class = "Array"
        else
          self.answer_value = data_structure[data_structure.keys.sample]
          self.data_structure_class = "Hash"
        end
      end
    end

    def print_data_structure_access_prompt
      answer_value_class = self.answer_value.class.to_s
      answer_value_class = "Boolean" if answer_value_class.match /(TrueClass|FalseClass)/
      answer_value_string = answer_value_class == "String" ? "'#{self.answer_value}'" : self.answer_value.to_s
      puts "Given the data structure below, how would you access the #{answer_value_class} value, ".blue + "#{answer_value_string}".yellow + " ?\n".blue
      print "#{self.variable_name} = ".green
      ap(data_structure, { indent: -2, index: false, multiline: true, plain: true})
      puts ""
    end

    def enter_evaluation_loop(&block)
      answered_correctly = false
      until answered_correctly
        user_input = Readline.readline("> ".blue, true)
        abort("Goodbye!".green) if user_input.match /^exit\s?/i
        # puts self.explanation.red if user_input.match /^explain\s?/i
        if yield(user_input)
          print_congratulation
          sleep 1.6
          clear_display
          answered_correctly = true
        end
      end
    end

    def evaluate_data_structure_access_input(evaluation_scope)
      enter_evaluation_loop do |user_input|
        begin
          # provides the evaluation scope with variable assignment necessary for answer eval
          evaluation_scope.eval("#{self.variable_name} = #{self.data_structure.to_s}")
          if evaluation_scope.eval(user_input) == self.answer_value
            # this last returned value of 'true' within the block is vital, as within the enter_evaluation_loop method, the return value of yield is used as a conditional.
            true
          else
            puts "Remember, #{self.hint} Try again.".red
          end
        rescue NameError
          print_colorized_name_error_prompt
        rescue TypeError => e
          # binding.pry
          # user_input.match /\[(.+)\]/i

          puts "\nNope! You just triggered a common Ruby error that reads:\n".red
          puts "\tin '[]', #{e.message}".green
          e.message.match /conversion\sof\s(.+)\sinto\sInteger/i
          # self.explanation = "Here's what's happening: Ruby saw a pair of square backets tacked on to the end of an array, and because array values are accessed via index (an integer), Ruby expected the value between square brackets TO BE AN INTEGER. Ruby played nice and tried to convert the given #{$1} to an integer, but doing so broke the world."

          puts "\nBasically, you put a #{$1} between square brackets, whereas Ruby was expecting an index value, i.e. an integer. This commonly arises when programmers think they're dealing with a hash, when in fact they're dealing with an array.\n".red
        end
      end
    end

  end # Question

  class VariableQuestion < Question
    # using a class instance variable, as manipulating a single class variable in the parent class is troublesome
    @questions = VARIABLE_QUESTIONS.shuffle

    def initialize
      super
      @variable_name = data[:possible_variable_names].sample
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


  def clear_display
    `reset`
  end

  def print_menu_options
    puts " What would you like to work on?".blue
    puts "1. Variable assignment"
    puts "2. Accessing values from arrays/hashes"
    puts "3. Accessing values from within nested data structures"
    puts "Q. Quit\r\n\n"
  end

  def random_congratulation
    ["Lovely work, my friend!", "Beautiful!", "Lovely!", "Splendid!", "Nice job! Keep it rolling!", "Capital work, battlestar!", "You're on your way!", "Exemplary work!", "Yeah!", "Roll on.", "You're making a prosperous go of this programming thing.", "Bullseye!", "Woo!", "Let it ride!", ""].sample
  end

  def print_congratulation
    puts "#{random_congratulation}\n".green
  end

  def print_colorized_name_error_prompt
    puts "You're referencing a variable that doesn't exist, probably as the result of a mispelling. This results in a common error that says: \n\n".red
    puts "\tundefined local variable or method \'WHATEVER_YOU_MISTYPED\'\n".green
    puts "Get used to it and try again.".red
  end

end
