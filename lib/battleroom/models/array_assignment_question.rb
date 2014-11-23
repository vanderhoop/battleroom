require_relative '../data/array_questions'
require_relative './data_structure_assignment_question'

class ArrayAssignmentQuestion < DataStructureAssignmentQuestion

  @questions = ARRAY_QUESTIONS

  def initialize(scope)
    super(scope)
    format_array_for_assignment
    print_data_structure_assignment_prompt
    evaluate_data_structure_assignment_input
  end

  def format_array_for_assignment
    desired_array_size = rand(3..6)
    cull_array_to_valid_size_for_output(desired_array_size)
    if [1, 2, 3, 4, 5].sample.odd?
      self.value_to_replace = data_structure.sample
      self.value_to_replace_formatted = format_value_for_stdout_and_eval(value_to_replace)
    end
    self.assignment_value = possible_assignments.sample
    self.assignment_value_class = format_class_for_output(assignment_value.class)
    self.formatted_assignment_value = format_value_for_stdout_and_eval(assignment_value)
  end

  def cull_array_to_valid_size_for_output(desired_size)
    while data_structure.size > desired_size
      new_assignment_possibility = data_structure.delete(data_structure.sample)
      possible_assignments.push(new_assignment_possibility)
    end
  end

  def print_replace_array_value_prompt
    battleprint "Given the data structure below, replace the #{replacement_value_class_formatted} value ".blue +
                value_to_replace_formatted.yellow + " with the #{assignment_value_class} value ".blue +
                formatted_assignment_value.yellow + ".\n\n"
  end

  def print_data_structure_assignment_prompt
    if value_to_replace
      self.replacement_index = data_structure.index(value_to_replace)
      self.replacement_value_class_formatted = format_class_for_output(value_to_replace.class)
      print_replace_array_value_prompt
    else
      battleprint "Use an array method to add the #{assignment_value_class} value ".blue + "#{formatted_assignment_value}".yellow + " to the ".blue + "end".blue.underline + " of the Array below.\n".blue
    end
    print_data_structure
  end

  def handle_replacement_of_array_value_input(user_input)
    if evaluation_scope.eval("#{variable_name}[#{replacement_index}] == #{formatted_assignment_value}") && user_input.include?(variable_name)
      print_resulting_data_structure
      true
    else
      print_incorrect_input_prompt
    end
  end

  def print_incorrect_input_prompt
    battleprint "\nNope! Here's what the data stucture would look like given your code:\n".red
    resulting_data_structure = evaluation_scope.eval(variable_name)
    ap(resulting_data_structure, { indent: -2, index: false, multiline: true, plain: true })
    battleprint "\nCheck your index and assignment values and try again.\n".red
  end

  def handles_user_workarounds(user_input)
    cheater_regex = Regexp.new("#{variable_name}\s+?\=\s+?(\\[)?")
    # checks if user reassigned the variable to a new array of identical values
    if user_input.match(cheater_regex)
      if $1
        battleprint "You reassigned the variable to a new array object, when you could have worked with the array provided! Look up Ruby's Array#push method and try again!\n".red
      else
        battleprint 'You reassigned the variable '.red + variable_name.green + " rather than working with the array provided. Try again.\n".red
      end
      true
    end
  end

  def evaluate_user_input(user_input)
    if handles_user_workarounds(user_input)
      false
    end
    if value_to_replace
      handle_replacement_of_array_value_input(user_input)
    elsif evaluation_scope.eval("#{variable_name}.last == #{formatted_assignment_value}") && user_input.include?(variable_name)
      print_resulting_data_structure
      true
    else
      battleprint 'Nope! Try again.'.red
    end
  end

end
