require_relative './question'

class DataStructureQuestion < Question
  attr_accessor :data_structure, :hint, :possible_assignments

  def initialize
    super
    @data_structure = data[:data_structure].clone
    self.possible_assignments = []
    if data_structure.class == Array
      # randomizes and shuffles the items in the arrays, so repeats remain interesting
      self.data_structure = data_structure.shuffle
      self.hint = 'index values start at 0.'
    else
      self.hint = 'you have to use the EXACT hash key to retrieve the associated value.'
    end
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
