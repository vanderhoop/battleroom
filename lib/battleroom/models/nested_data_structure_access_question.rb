require_relative 'data_structure_access_question'
require_relative '../question_data/nested_data_structure_access'

class NestedDataStructureAccessQuestion < DataStructureAccessQuestion

  # class instance variable used within the initialize method for Question
  @questions = NESTED_DATA_STRUCTURE_ACCESS_QUESTIONS.shuffle

  def initialize
    super
    if data_structure.class == Array
      self.inner_hash = data_structure.sample
      self.answer_value = inner_hash[inner_hash.keys.sample]
    else
      self.answer_value = data_structure[data_structure.keys.sample]
    end
  end

end
