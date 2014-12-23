require_relative './data_structure_question'

class DataStructureAccessQuestion < DataStructureQuestion

  def print_data_structure_access_prompt
    answer_value_class = format_class_for_output(answer_value.class)
    answer_value_string = format_value_for_stdout_and_eval(answer_value)
    battleprint "Given the data structure below, access the #{answer_value_class} value ".blue + answer_value_string.yellow + ".\n".blue
    print "#{variable_name} = ".green
    if data_structure.to_s.length < 100
      print_data_structure_on_single_line
    else
      ap(data_structure, { indent: -2, index: false, multiline: true, plain: true })
    end
    battleprint ''
  end

  def provide_evaluation_scope_with_variable_assignment_necessary_for_answer_eval
    evaluation_scope.eval("#{variable_name} = #{data_structure.to_s}")
  end

  def generate_readable_single_line_hash
    data_structure.to_s.gsub('{', '{ ').gsub('=>', ' => ').gsub('}', ' }')
  end

  def print_data_structure_on_single_line
    single_line_hash_as_string = generate_readable_single_line_hash()
    battleprint(single_line_hash_as_string)
  end

  def evaluate_data_structure_access_input
    enter_evaluation_loop do |user_submission|
      begin
        provide_evaluation_scope_with_variable_assignment_necessary_for_answer_eval()
        if evaluation_scope.eval(user_submission) == answer_value && user_submission.include?(variable_name)
          true
        else
          battleprint "Remember, #{hint} Try again.".red
        end
      rescue NameError => e
        print_colorized_error_prompt(e)
      rescue TypeError => e
        print_colorized_type_error_prompt(e)
      end
    end
  end
end
