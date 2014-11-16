require_relative 'question'

class FollowUpQuestion < Question

  attr_reader :original_question

  def initialize(evaluation_scope, original_question)
    @evaluation_scope = evaluation_scope
    @original_question = original_question
  end

end
