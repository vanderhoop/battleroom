require_relative './data_structure_access_question'
require_relative '../data/nested_data_structure_access_questions'

class NestedDataStructureAccessQuestion < DataStructureAccessQuestion
  attr_accessor :inner_hash, :inner_array
  # class instance variable used within the initialize method for Question
  @questions = NESTED_DATA_STRUCTURE_ACCESS_QUESTIONS.shuffle

  def initialize(eval_scope)
    super(eval_scope)
    if data_structure.class == Array
      self.inner_hash = data_structure.sample
      self.answer_value = inner_hash[inner_hash.keys.sample]
    else
      self.answer_value = data_structure[data_structure.keys.sample]
    end
    print_data_structure_access_prompt
    evaluate_data_structure_access_input
  end
end

