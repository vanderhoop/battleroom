require_relative './data_structure_question'
require_relative '../data/data_structure_assignment_questions'

class DataStructureAssignmentQuestion < DataStructureQuestion
  @questions = DATA_STRUCTURE_ASSIGNMENT_QUESTIONS.shuffle
  attr_accessor :assignment_value, :assignment_key, :assignment_value_class,
                :possible_assignments, :formatted_assignment_value

  def initialize
    super
    self.possible_assignments = []
    if data_structure.class == Array
      desired_array_size = rand(3..6)
      while data_structure.size > desired_array_size
        new_assignment_possibility = data_structure.delete(data_structure.sample)
        possible_assignments.push(new_assignment_possibility)
      end
      self.assignment_value = possible_assignments.sample
      self.formatted_assignment_value = format_value_for_stdout_and_eval(assignment_value)
    else
      while data_structure.size > 2
        key_to_delete = data_structure.keys.sample
        value_deleted = data_structure.delete(key_to_delete)
        new_assignment_possibility = { key_to_delete => value_deleted }
        possible_assignments.push(new_assignment_possibility)
      end
      assignment = possible_assignments.sample
      self.assignment_value = assignment.values[0]
      self.formatted_assignment_value = format_value_for_stdout_and_eval(assignment_value)
      self.assignment_key = format_value_for_stdout_and_eval(assignment.keys[0])
    end
    self.assignment_value_class = format_class_for_output(assignment_value.class)
  end

  def print_data_structure_assignment_prompt
    if data_structure.class == Array
      puts "Use an array method to add the #{assignment_value_class} value ".blue + "#{formatted_assignment_value}".yellow + " to the ".blue + "end".blue.underline + " of the Array below.\n".blue
    else
      puts "Given the Hash below, add a key of ".blue + assignment_key.yellow + " that points to the #{assignment_value_class} value of ".blue + "#{formatted_assignment_value}".yellow + ".\n\n"
    end
    print "#{variable_name} = ".green
    ap(data_structure, { indent: -2, index: false, multiline: true, plain: true })
    puts ""
  end

  def print_resulting_data_structure(evaluation_scope)
    puts "\n#{['Brilliant', 'Wonderful', 'Jackpot', 'Impressive work', 'Bang-up job', 'Dynamite', 'Premier work', 'Quality work', 'Terrific', 'Topping work'].sample}. Here's the resulting data structure:\n".green
    sleep 1.0
    resulting_data_structure = evaluation_scope.eval(variable_name)
    ap(resulting_data_structure, { indent: -2, index: false, multiline: true, plain: true })
    puts ""
    sleep 3.2
  end

  def handle_potential_workarounds(user_input)
    cheater_regex = Regexp.new("#{variable_name}\s+?\=\s+?(\\[)?")
    # checks if user reassigned the variable to a new array of identical values
    if user_input.match(cheater_regex)
      if $1
        puts "You reassigned the variable to a new array object, when you could have worked with the array provided! Look up Ruby's Array#push method and try again!".red
      else
        puts "You reassigned the variable ".red + variable_name.green + " rather than working with the array provided. Try again.".red
      end
      true
    end
  end

  def evaluate_data_structure_assignment_input(evaluation_scope)
    enter_evaluation_loop do |user_input|
      begin
        # provides the evaluation scope with variable assignment necessary for answer eval
        evaluation_scope.eval("#{variable_name} = #{data_structure.to_s}")
        evaluation_scope.eval(user_input)
        if data_structure.class == Array
          if handle_potential_workarounds(user_input)
            false
          elsif evaluation_scope.eval("#{variable_name}.last == #{formatted_assignment_value}") && user_input.include?(variable_name)
            print_resulting_data_structure(evaluation_scope)
            true
          else
            puts "Nope! Ruby's Array#push method will be your salvation. Look it up!".red
            false
          end
        else
          if evaluation_scope.eval("#{variable_name}[#{assignment_key}] == #{formatted_assignment_value}") && user_input.include?(variable_name)
            print_resulting_data_structure(evaluation_scope)
            true
          else
            puts "Nope! Try again!".red
          end
        end
      rescue NoMethodError, NameError => e
        print_colorized_error_prompt(e)
      rescue TypeError => e
        print_colorized_type_error_prompt(e)
      end
    end
  end

end
