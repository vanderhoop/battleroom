require_relative './question'

class DataStructureQuestion < Question
  attr_accessor :data_structure, :hint

  def initialize
    super
    @data_structure = data[:data_structure]
    if data_structure.class == Array
      # randomizes and shuffles the items in the arrays, so repeats remain interesting
      self.data_structure = data_structure.shuffle[0, rand(3..6)]
      self.hint = "index values start at 0."
    else
      self.hint = "you have to use the EXACT hash key to retrieve the associated value."
    end
  end

end
