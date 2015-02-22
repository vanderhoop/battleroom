require_relative '../../lib/battleroom/data/array_questions'

def each_array_question(&block)
  ARRAY_QUESTIONS.each do |array_question|
    yield(array_question)
  end
end

describe "ARRAY_QUESTIONS" do
  it "is an array" do
    expect(ARRAY_QUESTIONS.class).to eq(Array)
  end

  it "has contents" do
    expect(ARRAY_QUESTIONS.size).to be > 0
  end

  describe "each Array question" do
    it "is stored as a hash" do
      each_array_question do |array_question|
        expect(array_question.class).to eq(Hash)
      end
    end

    it "has an array of possible variable names" do
      each_array_question do |array_question|
        expect(array_question[:possible_variable_names].class).to eq(Array)
        expect(array_question[:possible_variable_names].size).to be > 0
      end
    end

    it "has an array as its 'data structure'" do
      each_array_question do |array_question|
        expect(array_question[:data_structure].class).to eq(Array)
      end
    end

    describe "each array" do

      it "has at least 5 values" do
        each_array_question do |array_question|
          data_structure = array_question[:data_structure]
          expect(data_structure.size).to be >= 5
        end
      end

      it "contains no duplicates" do
        each_array_question do |array_question|
          array = array_question[:data_structure]
          original_size = array.size
          array.uniq!
          expect(original_size).to eq(array.size)
        end
      end

    end

  end

end
