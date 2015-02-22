require_relative '../../lib/battleroom/models/variable_assignment_question'

stand_in_data = {
  possible_variable_names: [
    'days_without_rain'
  ],
  possible_variable_values: [5]
}

# Readline.pre_input_hook = proc { self.user_input = "days_without_rain = 5"; return }

describe VariableAssignmentQuestion do
  before(:each) do
    @printer = double("printer")
    allow(@printer).to receive(:print_prompt)
    @question = VariableAssignmentQuestion.new(
      evaluation_scope: binding,
      printer: @printer,
      question_data: stand_in_data
    )
  end

  describe ".new" do
    it "commands its printer to print the question prompt" do
      @question.user_input = "days_without_rain = 5"
      @question.init
      expect(@printer).to have_received(:print_prompt)
    end

    # it "asks the user for input" do
    #   Readline.readline("days_without_rain = 5")
    #   # STDIN.should_receive(:read).and_return("days_without_rain = 5")
    #   expect(printer).to have_received(:print_prompt)
    # end
  end
end
