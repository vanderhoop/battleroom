require_relative './data_structure_question'

class DataStructureAssignmentQuestion < DataStructureQuestion
  @questions = DATA_STRUCTURE_ACCESS_QUESTIONS.shuffle
  attr_accessor :assignment_value, :assignment_key, :assignment_value_class, :assignment_value_string

  def initialize
    super
    if data_structure.class == Array
      self.assignment_value = data[:possible_assignments].sample
    else
      assignment = data[:possible_assignments].sample
      self.assignment_value = assignment.values[0]
      self.assignment_key = assignment.keys[0]
    end
    self.assignment_value_class = self.assignment_value.class.to_s
    self.assignment_value_class = "Boolean" if assignment_value_class.match /(TrueClass|FalseClass)/
    self.assignment_value_string = self.assignment_value_class == "String" ? "'#{self.assignment_value}'" : self.assignment_value.to_s
  end

  def print_data_structure_assignment_prompt
    if data_structure.class == Array
      puts "Use an array method to add the #{assignment_value_class} value, ".blue + "#{assignment_value_string}".yellow + " to the end of the Array below\n\n".blue
    else
      puts "Given the Hash below, add a key of ".blue + ":#{assignment_key}".yellow + " that points to the #{assignment_value_class} value of ".blue + "#{assignment_value}".yellow + ".\n\n"
    end
    print "#{self.variable_name} = ".green
    ap(data_structure, { indent: -2, index: false, multiline: true, plain: true })
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

end
