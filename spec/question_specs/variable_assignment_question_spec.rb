require_relative '../../lib/battleroom/models/variable_assignment_question'

stand_in_data = {
  possible_variable_names: [
    'days_without_rain'
  ],
  possible_variable_values: [5]
}

# Readline.pre_input_hook = proc { self.user_input = "days_without_rain = 5"; return }

# def Readline.readline(*)
#   "marp"
# end

describe VariableAssignmentQuestion do
  before(:each) do
    @printer = double("printer")
    allow(@printer).to receive(:print_prompt)
    allow(@printer).to receive(:init_congratulation_sequence)
    @question = VariableAssignmentQuestion.new(
      evaluation_scope: binding,
      printer:          @printer,
      question_data:    stand_in_data
    )
  end

  describe "#init" do
    it "commands its printer to print the question prompt" do
      Readline.stub(:readline).and_return('days_without_rain = 5')
      @question.init
      expect(@printer).to have_received(:print_prompt)
    end

    context "when the user enters the correct input" do
      it 'only invokes Readline::readline once' do
        Readline.stub(:readline).and_return('days_without_rain = 5')
        expect(Readline).to receive(:readline).exactly(:once)
        @question.init
      end

      it "invokes the congratulation sequence" do
        Readline.stub(:readline).and_return('days_without_rain = 5')
        @question.init
        expect(@printer).to have_received(:init_congratulation_sequence)
      end
    end

    context "when the user enters the incorrect variable assignment" do
      it "asks the user for input until the correct answer is given" do

      end
    end

  end
end
