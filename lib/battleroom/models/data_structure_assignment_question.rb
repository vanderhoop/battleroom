require_relative './data_structure_question'

class DataStructureAssignmentQuestion < DataStructureQuestion

  attr_accessor :assignment_value, :assignment_key, :assignment_value_class,
                :formatted_assignment_value, :value_to_replace,
                :value_to_replace_formatted, :replacement_index,
                :replacement_value_class_formatted

  def initialize(eval_scope)
    super(eval_scope)
  end

  def print_resulting_data_structure
    possible_intro_congratulations = [
      'Brilliant',
      'Wonderful',
      'Jackpot',
      'Impressive work',
      'Bang-up job',
      'Dynamite',
      'Premier work',
      'Quality work',
      'Terrific'
    ]
    intro_congrat = possible_intro_congratulations.sample
    puts "\n#{intro_congrat}. Here's the resulting data structure:\n".green
    sleep 1.0
    resulting_data_structure = evaluation_scope.eval(variable_name)
    ap(resulting_data_structure, { indent: -2, index: false, multiline: true, plain: true })
    puts ''
    sleep 3.2
  end

  def evaluate_data_structure_assignment_input
    enter_evaluation_loop do |user_input|
      begin
        # provides the evaluation scope with variable assignment necessary for answer eval
        evaluation_scope.eval("#{variable_name} = #{data_structure.to_s}")
        evaluation_scope.eval(user_input)
        evaluate_user_input(user_input)
      rescue NoMethodError, NameError => e
        print_colorized_error_prompt(e)
      rescue TypeError => e
        print_colorized_type_error_prompt(e)
      end
    end
  end

end
