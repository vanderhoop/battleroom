require_relative '../../lib/battleroom/data/variable_assignment_questions'

describe "VARIABLE_QUESTIONS" do
  it "is an array" do
    expect(VARIABLE_QUESTIONS.class).to eq(Array)
  end
end
