require_relative '../data/array_questions'
require_relative './data_structure_access_question'

class ArrayAccessQuestion < DataStructureAccessQuestion

  @questions = ARRAY_QUESTIONS.shuffle

  def initialize(scope)
    super(scope)
    format_array_for_access
    print_data_structure_access_prompt
    evaluate_data_structure_access_input
  end

  def format_array_for_access
    self.data_structure = data_structure[0, rand(4..6)]
    self.answer_value = data_structure.sample
    self.hint = 'index values start at 0.'
  end

end
