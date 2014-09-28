require_relative '../data/data_structure_questions'
require_relative './data_structure_question'

class DataStructureAccessQuestion < DataStructureQuestion
  @questions = DATA_STRUCTURE_QUESTIONS.shuffle
  attr_accessor :assignment_value, :assignment_key, :assignment_value_class

  def initialize
    super
    format_based_on_data_structure_class
  end

  def format_based_on_data_structure_class
    if data_structure.class == Array
      format_array
    else
      format_hash
    end
  end

  def format_array
    self.data_structure = data_structure[0, rand(4..6)]
    self.answer_value = data_structure.sample
    self.hint = 'index values start at 0.'
  end

  def format_hash
    cull_hash_to_valid_size_for_output
    remove_multiple_booleans
    self.answer_value = data_structure[data_structure.keys.sample]
    self.hint = 'you have to use the EXACT hash key to retrieve the associated value.'
  end

  def remove_multiple_booleans
    boolean_count = find_number_of_boolean_values_in_hash
    while boolean_count > 1
      grouped_by_value = data_structure.group_by { |k, v| v }
      boolean_to_delete = [true, false].sample
      key_to_delete = grouped_by_value[boolean_to_delete].sample[0] if grouped_by_value[boolean_to_delete]
      data_structure.delete(key_to_delete)
      boolean_count = find_number_of_boolean_values_in_hash
    end
  end

  def print_data_structure_access_prompt
    answer_value_class = format_class_for_output(answer_value.class)
    answer_value_string = format_value_for_stdout_and_eval(answer_value)
    puts "Given the data structure below, access the #{answer_value_class} value ".blue + answer_value_string.yellow + ".\n".blue
    print "#{variable_name} = ".green
    if data_structure.to_s.length < 40
      puts data_structure.to_s.gsub('{', '{ ').gsub('=>', ' => ').gsub('}', ' }')
    else
      ap(data_structure, { indent: -2, index: false, multiline: true, plain: true })
    end
    puts ''
  end

  def evaluate_data_structure_access_input(evaluation_scope)
    enter_evaluation_loop do |user_input|
      begin
        # provides the evaluation scope with variable assignment necessary for answer eval
        evaluation_scope.eval("#{variable_name} = #{data_structure.to_s}")
        if evaluation_scope.eval(user_input) == answer_value && user_input.include?(variable_name)
          # this last returned value of 'true' within the block is vital;
          # within the enter_evaluation_loop method, the return value of yield is used
          true
        else
          puts "Remember, #{hint} Try again.\n".red
        end
      rescue NameError => e
        print_colorized_error_prompt(e)
      rescue TypeError => e
        print_colorized_type_error_prompt(e)
      end
    end
  end
end
