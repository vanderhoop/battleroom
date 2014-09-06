require_relative './question'
require_relative '../question_data/data_structure_access'

class DataStructureAccessQuestion < Question
  @questions = DATA_STRUCTURE_ACCESS_QUESTIONS.shuffle
  attr_accessor :assignment_value, :assignment_key, :assignment_value_class, :assignment_value_string

  def initialize
    super
    @data_structure = data[:data_structure]
    if data_structure.class == Array
      # randomizes and shuffles the items in the arrays, so repeats remain interesting
      self.data_structure = data_structure.shuffle[0,3]
      self.answer_value = data_structure.sample
      self.assignment_value = data[:possible_assignments].sample
      self.hint = "index values start at 0."
    else
      self.answer_value = data_structure[data_structure.keys.sample]
      self.hint = "you have to use the EXACT hash key to retrieve the associated value."
      self.assignment_value = data[:possible_assignments].sample.values[0]
      self.assignment_key = data[:possible_assignments].sample.keys[0]
    end
    self.assignment_value_class = self.assignment_value.class.to_s
    self.assignment_value_class = "Boolean" if assignment_value_class.match /(TrueClass|FalseClass)/
    self.assignment_value_string = self.assignment_value_class == "String" ? "'#{self.assignment_value}'" : self.assignment_value.to_s
  end

  def print_data_structure_assignment_prompt
    # assignment_value_class = self.assignment_value.class.to_s
    # assignment_value_class = "Boolean" if assignment_value_class.match /(TrueClass|FalseClass)/
    # adds single quotes around string values
    # assignment_value_string = assignment_value_class == "String" ? "'#{self.assignment_value}'" : self.assignment_value.to_s
    if data_structure.class == Array
      puts "Use an array method to add the #{assignment_value_class} value, ".blue + "#{assignment_value_string}".yellow + " to the end of the Array below\n\n".blue
    else
      puts "Given the Hash below, add a key of ".blue + ":#{assignment_key}".yellow + " that points to the #{assignment_value_class} value of ".blue + "#{assignment_value}".yellow + ".\n\n"
    end
    print "#{self.variable_name} = ".green
    ap(data_structure, { indent: -2, index: false, multiline: true, plain: true})
    puts ""
  end

  def evaluate_data_structure_assignment_input(evaluation_scope)
    enter_evaluation_loop do |user_input|
      begin
        # provides the evaluation scope with variable assignment necessary for answer eval
        evaluation_scope.eval("#{self.variable_name} = #{self.data_structure.to_s}")
        if self.data_structure.class == Array
          evaluation_scope.eval(user_input)
          if evaluation_scope.eval("#{self.variable_name}.last == #{self.assignment_value_string}") && user_input.include?(self.variable_name)
            # this last returned value of 'true' within the block is vital, as within the enter_evaluation_loop method, the return value of yield is used as a conditional.
            true
          else
            puts "Remember, #{self.hint} Try again.".red
          end
        else
          evaluation_scope.eval(user_input)
          if evaluation_scope.eval("#{self.variable_name}[:#{self.assignment_key}] == #{self.assignment_value}") && user_input.include?(self.variable_name)
            true
          end
        end
      rescue NameError => e
        print_colorized_name_error_prompt(e)
      rescue TypeError => e
        puts "\nNope! You just triggered a common Ruby error that reads:\n".red
        puts "\tin '[]', #{e.message}".green
        e.message.match /conversion\sof\s(.+)\sinto\sInteger/i
        puts "\nBasically, you put a #{$1} between square brackets, whereas Ruby was expecting an index value, i.e. an integer. This commonly arises when programmers think they're dealing with a hash, when in fact they're dealing with an array.\n".red
      end
    end
  end

  # def print_data_structure_access_prompt
  #   answer_value_class = self.answer_value.class.to_s
  #   answer_value_class = "Boolean" if answer_value_class.match /(TrueClass|FalseClass)/
  #   answer_value_string = answer_value_class == "String" ? "'#{self.answer_value}'" : self.answer_value.to_s
  #   puts "Given the data structure below, how would you access the #{answer_value_class} value, ".blue + "#{answer_value_string}".yellow + " ?\n".blue
  #   print "#{self.variable_name} = ".green
  #   ap(data_structure, { indent: -2, index: false, multiline: true, plain: true })
  #   puts ""
  # end


  # def evaluate_data_structure_access_input(evaluation_scope)
  #   enter_evaluation_loop do |user_input|
  #     begin
  #       # provides the evaluation scope with variable assignment necessary for answer eval
  #       evaluation_scope.eval("#{self.variable_name} = #{self.data_structure.to_s}")
  #       if evaluation_scope.eval(user_input) == self.answer_value && user_input.include?(self.variable_name)
  #         # this last returned value of 'true' within the block is vital, as within the enter_evaluation_loop method, the return value of yield is used as a conditional.
  #         true
  #       else
  #         puts "Remember, #{self.hint} Try again.".red
  #       end
  #     rescue NameError => e
  #       print_colorized_name_error_prompt(e)
  #     rescue TypeError => e
  #       puts "\nNope! You just triggered a common Ruby error that reads:\n".red
  #       puts "\tin '[]', #{e.message}".green
  #       e.message.match /conversion\sof\s(.+)\sinto\sInteger/i
  #       puts "\nBasically, you put a #{$1} between square brackets, whereas Ruby was expecting an index value, i.e. an integer. This commonly arises when programmers think they're dealing with a hash, when in fact they're dealing with an array.\n".red
  #     end
  #   end
  # end
end
