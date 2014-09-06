class Question
    attr_reader :type, :data
    attr_accessor :variable_name, :variable_value, :value_type, :data_structure,
                  :hint, :data_structure_class, :answer_value, :inner_hash,
                  :inner_array, :explanation

    def initialize
      @data = self.class.generate_question
      @variable_name = data[:possible_variable_names].sample
    end

    # retrieves question from front of the array and rotates it to the back to avoid immediate re-sampling of questions
    def self.generate_question
      # calls upon *class instance* variable set in the subclasses
      question = @questions.shift
      @questions.push(question)
      question
    end

    def enter_evaluation_loop(&block)
      answered_correctly = false
      until answered_correctly
        user_input = Readline.readline("> ".blue, true)
        abort("Goodbye!".green) if user_input.match /^exit\s?/i
        if yield(user_input)
          print_congratulation
          sleep 1.6
          clear_display
          answered_correctly = true
        end
      end
    end

  end # Question
