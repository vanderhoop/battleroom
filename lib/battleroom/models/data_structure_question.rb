require_relative './question'

class DataStructureQuestion < Question
  attr_accessor :data_structure, :hint, :possible_assignments

  def post_initialize
    @data_structure = data[:data_structure].clone
    if data_structure.class == Array
      # randomizes and shuffles the items in the arrays, so repeats remain interesting
      self.data_structure = data_structure.shuffle
      self.hint = 'index values start at 0.'
    else
      convert_keys_to_strings if [0,1,2,3,4].sample.odd?
      self.hint = 'you have to use the EXACT hash key to retrieve the associated value.'
    end
    self.possible_assignments = []
  end

  def convert_keys_to_strings
    altered_ds = data_structure.each_with_object({}) do |key_value_array, new_hash|
      old_key = key_value_array[0]
      value = key_value_array[1]
      new_hash[old_key.to_s] = value
    end
    self.data_structure = altered_ds
  end

  def cull_hash_to_valid_size_for_output
    desired_hash_size = rand(2..4)
    while data_structure.size > desired_hash_size
      key_to_delete = data_structure.keys.sample
      value_deleted = data_structure.delete(key_to_delete)
      new_assignment_possibility = { key_to_delete => value_deleted }
      possible_assignments.push(new_assignment_possibility)
    end
  end

  def find_number_of_boolean_values_in_hash
    data_structure.select { |key, value| value.to_s.match(/true|false/i) }.size
  end

end
