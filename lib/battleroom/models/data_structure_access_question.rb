require_relative './data_structure_question'

class DataStructureAccessQuestion < DataStructureQuestion

  def initialize(eval_scope)
    super(eval_scope)
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

  def evaluate_data_structure_access_input
    enter_evaluation_loop do |user_submission|
      begin
        # provides the evaluation scope with variable assignment necessary for answer eval
        evaluation_scope.eval("#{variable_name} = #{data_structure.to_s}")
        if evaluation_scope.eval(user_submission) == answer_value && user_submission.include?(variable_name)
          # this last returned value of 'true' within the block is vital;
          # within the evaluation_loop method, the return value of yield is used
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
