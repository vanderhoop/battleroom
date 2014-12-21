require_relative 'question'

class FollowUpQuestion < Question

  attr_reader :original_question

  def initialize(evaluation_scope, original_question)
    @evaluation_scope = evaluation_scope
    @original_question = original_question
    @input_mechanism = 'readline'
    post_initialize
  end

  def post_initialize
    nil
  end

end
