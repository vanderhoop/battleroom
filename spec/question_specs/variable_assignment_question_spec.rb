require_relative '../../lib/battleroom/models/variable_assignment_question'

STUB_QUESTION_DATA = {
  possible_variable_names: [
    'consecutive_wins',
    'consecutive_losses',
    'days_without_rain'
  ].shuffle,
  possible_variable_values: (1..100).to_a.shuffle
}

describe VariableAssignmentQuestion do
  describe ".new" do
    it "tells its printer to print the prompt" do
      printer = double("printer")
      allow(printer).to receive(:print_prompt)
      question = VariableAssignmentQuestion.new(evaluation_scope: binding, printer: printer)
      expect(printer).to have_received(:print_prompt)
    end
  end
end
