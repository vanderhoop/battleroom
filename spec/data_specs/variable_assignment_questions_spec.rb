require_relative '../../lib/battleroom/data/variable_assignment_questions'

describe "VARIABLE_QUESTIONS" do
  it "is an array" do
    expect(VARIABLE_QUESTIONS.class).to eq(Array)
  end

  it "has at least 5 values" do
    expect(VARIABLE_QUESTIONS.size).to be >= 5
  end

  describe "each Variable Question" do
    it "is stored as a hash" do
      VARIABLE_QUESTIONS.each do |variable_question|
        expect(variable_question.class).to eq(Hash)
      end
    end

    it "has an array of possible_variable_names" do
      VARIABLE_QUESTIONS.each do |variable_question|
        expect(variable_question[:possible_variable_names].class).to eq(Array)
      end
    end

    describe "each array of possible_variable_names" do
      it "has contents" do
        VARIABLE_QUESTIONS.each do |variable_question|
          expect(variable_question[:possible_variable_names].size).to be >= 1
        end
      end
    end
  end
end
