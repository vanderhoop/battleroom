require_relative '../../lib/battleroom/data/hash_questions'

def each_hash_question(&block)
  HASH_QUESTIONS.each do |hash_question|
    yield(hash_question)
  end
end

describe "HASH_QUESTIONS" do
  it "is an array" do
    expect(HASH_QUESTIONS.class).to eq(Array)
  end

  it "has contents" do
    expect(HASH_QUESTIONS.size).to be > 0
  end

  describe "each hash question" do
    it "is stored as a hash" do
      each_hash_question do |hash_question|
        expect(hash_question).to respond_to(:has_key?)
      end
    end

    it "has an array of possible variable names" do
      each_hash_question do |hash_question|
        expect(hash_question[:possible_variable_names].class).to eq(Array)
        expect(hash_question[:possible_variable_names].size).to be > 0
      end
    end

    it "has a hash as its 'data structure'" do
      each_hash_question do |hash_question|
        expect(hash_question[:data_structure].class).to eq(Hash)
      end
    end

    describe "each 'data_structure'" do
      it "has at least 5 values" do
        each_hash_question do |hash_question|
          data_structure = hash_question[:data_structure]
          expect(data_structure.values.size).to be >= 5
        end
      end

    end

  end # describe 'a question'

end
