require_relative './follow_up_question'

class VariableReferenceQuestion < FollowUpQuestion

  attr_accessor :required_return_value

  def initialize(scope, original_question)
    super(scope, original_question)
  end

  def print_variable_reference_prompt
    # formatted_class = format_class_for_output(original_question.variable_value.class)
    # battleprint "The variable ".blue + original_question.variable_name.yellow + " now holds a reference to the #{formatted_class} value ".blue + original_question.formatted_value.yellow + "\n"
    battleprint "You now have the variable assignment below at your disposal.\n".blue
    # I want to print an indented, syntax highlighted variable assignment
    battleprint "\t#{original_question.variable_name} = #{original_question.formatted_value}\n\n"
    prompt = develop_prompt
    puts prompt
  end

  def develop_prompt
    prompt = case original_question.variable_value.class.to_s
             when 'String'
               binding.pry
             when 'Fixnum'
              self.required_return_value = original_question.variable_value + (-12..12).to_a.sample
              prompt = "Use ".blue + original_question.variable_name.green + " in combination with an arithmetic operator like ".blue +  " + ".black.on_light_white + ", ".blue + " - ".black.on_light_white + ", ".blue + " * ".black.on_light_white + ", ".blue + " / ".black.on_light_white + ", or ".blue + " ** ".black.on_light_white + " to return the Fixnum value ".blue + required_return_value.to_s.green + ".\n".blue
             when 'Symbol'
               binding.pry
             when 'Float'
               binding.pry
             when 'TrueClass', 'FalseClass'
               binding.pry
             else
               binding.pry
             end
  end

  def evaluate_variable_reference_input
    enter_evaluation_loop do |user_submission|
      begin
        restore_pry_defaults
        # I need to provide the evaluation scope with the original variable assignment
        evaluation_scope.eval("#{original_question.variable_name} = #{original_question.formatted_value}")
        if (evaluation_scope.eval(user_submission) == required_return_value)
          true
        else
          puts "Looks like you messed up. Try again.".red
        end
      rescue NameError => e
        binding.pry
      rescue NoMethodError => e
        binding.pry
      end
    end
  end

end
