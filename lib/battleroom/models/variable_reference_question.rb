require_relative 'question'

class VariableReferenceQuestion < Question

  attr_reader :original_question

  def initialize(scope, original_question)
    super(scope)
    @original_question = original_question
  end

  def print_variable_reference_prompt
    battleprint "The variable #{original_question}".blue
  end

end
