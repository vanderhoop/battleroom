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
    allow(@printer).to receive(:init_congratulation_sequence)
    @question = VariableAssignmentQuestion.new(
      evaluation_scope: binding,
      printer: @printer,
      question_data: stand_in_data
    )
  end

  describe "#init" do
    it "commands its printer to print the question prompt" do
      @question.user_input = "days_without_rain = 5"
      @question.init
      expect(@printer).to have_received(:print_prompt)
    end

    context "when the user enters the correct input" do
      before(:each) do
        @question.user_input = "days_without_rain = 5"
      end

      it "invokes the congratulation sequence" do
        @question.init
        expect(@printer).to have_received(:init_congratulation_sequence)
      end
    end

    context "when the user enters the incorrect input" do

    end

  end
end
