require_relative '../data/hash_questions'
require_relative './data_structure_access_question'


class HashAccessQuestion < DataStructureAccessQuestion

  @questions = HASH_QUESTIONS.shuffle

  def initialize(scope)
    super(scope)
    format_hash
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

end
