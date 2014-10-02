require_relative '../data/hash_questions'
require_relative './data_structure_access_question'

class HashAssignmentQuestion < DataStructureAssignmentQuestion

  def initialize(scope)
    super(scope)
    format_hash
  end

  def format_hash
    cull_hash_to_valid_size_for_output
    assignment = possible_assignments.sample
    self.assignment_value = assignment.values[0]
    self.assignment_value_class = format_class_for_output(assignment_value.class)
    self.formatted_assignment_value = format_value_for_stdout_and_eval(assignment_value)
    self.assignment_key = format_value_for_stdout_and_eval(assignment.keys[0])
  end

  def print_data_structure_assignment_prompt
    puts 'Given the Hash below, add a key of '.blue + assignment_key.yellow + " that points to the #{assignment_value_class} value of ".blue + "#{formatted_assignment_value}".yellow + ".\n\n"
    print "#{variable_name} = ".green
    ap(data_structure, { indent: -2, index: false, multiline: true, plain: true })
    puts ''
  end

  def evaluate_user_input(user_input)
    if evaluation_scope.eval("#{variable_name}[#{assignment_key}] == #{formatted_assignment_value}") && user_input.include?(variable_name)
      print_resulting_data_structure
      true
    else
      puts 'Nope! Try again!'.red
    end
  end

end
