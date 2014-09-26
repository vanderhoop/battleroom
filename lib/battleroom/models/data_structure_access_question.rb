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
      self.data_structure = data_structure[0, rand(4..6)]
      self.answer_value = data_structure.sample
      self.hint = 'index values start at 0.'
    else
      remove_booleans
      self.answer_value = data_structure[data_structure.keys.sample]
      self.hint = 'you have to use the EXACT hash key to retrieve the associated value.'
    end
  end

  def remove_booleans
    self.data_structure.keep_if { |k, v| v.class != TrueClass }
    self.data_structure.keep_if { |k, v| v.class != FalseClass }
  end

  def print_data_structure_access_prompt
    answer_value_class = format_class_for_output(answer_value.class)
    answer_value_string = format_value_for_stdout_and_eval(answer_value)
    puts "Given the data structure below, access the #{answer_value_class} value ".blue + "#{answer_value_string}".yellow + ".\n".blue
    print "#{variable_name} = ".green
    if data_structure.to_s.length < 40
      puts data_structure.to_s
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
          puts "Remember, #{hint} Try again.".red
        end
      rescue NameError => e
        print_colorized_error_prompt(e)
      rescue TypeError => e
        print_colorized_type_error_prompt(e)
      end
    end
  end
end
