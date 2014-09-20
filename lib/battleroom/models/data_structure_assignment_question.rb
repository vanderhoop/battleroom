require_relative './data_structure_question'

class DataStructureAssignmentQuestion < DataStructureQuestion
  @questions = DATA_STRUCTURE_ACCESS_QUESTIONS.shuffle
  attr_accessor :assignment_value, :assignment_key, :assignment_value_class, :assignment_value_string

  def initialize
    super
    if data_structure.class == Array
      self.assignment_value = format_value_for_stdout_and_eval(data[:possible_assignments].sample)
    else
      assignment = data[:possible_assignments].sample
      self.assignment_value = format_value_for_stdout_and_eval(assignment.values[0])
      self.assignment_key = format_value_for_stdout_and_eval(assignment.keys[0])
    end
    self.assignment_value_class = format_class_for_output(assignment_value.class)
  end

  def print_data_structure_assignment_prompt
    if data_structure.class == Array
      puts "Use an array method to add the #{assignment_value_class} value ".blue + "#{assignment_value}".yellow + " to the end of the Array below.\n".blue
    else
      puts "Given the Hash below, add a key of ".blue + assignment_key.yellow + " that points to the #{assignment_value_class} value of ".blue + "#{assignment_value}".yellow + ".\n\n"
    end
    print "#{self.variable_name} = ".green
    ap(data_structure, { indent: -2, index: false, multiline: true, plain: true })
    puts ""
  end

  def print_resulting_data_structure(evaluation_scope)
    puts "\nBrilliant. Here's the resulting data structure.\n".green
    sleep 1.0
    resulting_data_structure = evaluation_scope.eval(variable_name)
    ap(resulting_data_structure, { indent: -2, index: false, multiline: true, plain: true })
    puts ""
    sleep 4.0
  end

  def evaluate_data_structure_assignment_input(evaluation_scope)
    enter_evaluation_loop do |user_input|
      begin
        # provides the evaluation scope with variable assignment necessary for answer eval
        evaluation_scope.eval("#{variable_name} = #{data_structure.to_s}")
        evaluation_scope.eval(user_input)
        if self.data_structure.class == Array
          cheater_regex = Regexp.new("#{variable_name}\s+?\=\s+?(\\[)?")
          # checks if user reassigned the variable to a new array of identical values
          if user_input.match(cheater_regex)
            if $1
              puts "You reassigned the variable to a new array object, when you could have worked with the array provided! Save yourself the fingerwork and look up Ruby's Array#push method!".red
            else
              puts "You reassigned the variable ".red + variable_name.green + " rather than working with it. Try again.".red
            end
            false
          elsif evaluation_scope.eval("#{variable_name}.last == #{assignment_value}") && user_input.include?(variable_name)
            print_resulting_data_structure(evaluation_scope)
            # this last returned value of 'true' within the block is vital, as within the enter_evaluation_loop method, the return value of yield is used as a conditional.
            true
          else
            puts "Nope! Ruby's Array#push method will be your salvation. Look it up!"
          end
        else
          if evaluation_scope.eval("#{variable_name}[#{assignment_key}] == #{assignment_value}") && user_input.include?(variable_name)
            print_resulting_data_structure(evaluation_scope)
            # # clear_display
            # puts "\nBrilliant. Here's the resulting data structure.\n".green
            # resulting_data_structure = evaluation_scope.eval(variable_name)
            # ap(resulting_data_structure, { indent: -2, index: false, multiline: true, plain: true })
            # puts ""
            # sleep 4.0
            true
          end
        end
      rescue NoMethodError, NameError => e
        print_colorized_error_prompt(e)
      rescue TypeError => e
        puts "\nNope! You just triggered a common Ruby error that reads:\n".red
        puts "\tin '[]', #{e.message}".green
        e.message.match /conversion\sof\s(.+)\sinto\sInteger/i
        puts "\nBasically, you put a #{$1} between square brackets, whereas Ruby was expecting an index value, i.e. an integer. This commonly arises when programmers think they're dealing with a hash, when in fact they're dealing with an array.\n".red
      end
    end
  end

end
