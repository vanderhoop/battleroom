require_relative './follow_up_question'

class VariableReferenceQuestion < FollowUpQuestion

  attr_accessor :required_return_value

  def post_initialize
    print_variable_reference_prompt
    evaluate_variable_reference_input
  end

  def print_variable_reference_prompt
    battleprint "You now have the variable assignment below at your disposal.\n".blue
    battleprint "\t#{original_question.variable_name} = #{original_question.formatted_value}\n\n"
    prompt = develop_prompt
    puts prompt
  end

  def a_value_within_12_more_or_12_less_than_the_original_assigned_value
    range = (-12..12).to_a
    range.delete(0)
    original_question.variable_value + range.sample
  end

  def a_value_that_doesnt_result_from_imprecise_float_arithmetic
    if original_question.variable_value < 15
      new_target_value = original_question.variable_value + rand(1..15)
    else
      new_target_value = a_value_within_12_more_or_12_less_than_the_original_assigned_value
    end
    count = 1
    while new_target_value.to_s.split(".").last.length > 4
      new_target_value = original_question.variable_value + count
      count += 1
    end
    new_target_value
  end

  def a_value_that_requires_low_arithmetic_complexity_to_arrive_at_via_multiplication_or_division
    value = original_question.variable_value
    if value < 12
      value * [3,4,5,6].sample
    elsif value < 50
      value * 2
    else
      value / 2
    end
  end

  def generate_appropriate_value
    value = original_question.variable_value
    if value.class == Fixnum
      if value.even?
        a_value_that_requires_low_arithmetic_complexity_to_arrive_at_via_multiplication_or_division
      else
        a_value_within_12_more_or_12_less_than_the_original_assigned_value
      end
    else
      a_value_that_doesnt_result_from_imprecise_float_arithmetic()
    end
  end

  def develop_prompt
    self.required_return_value = generate_appropriate_value()
    "Use ".blue + original_question.variable_name.green + " in combination with an arithmetic operator like ".blue +  codify(" + ") + ", ".blue + codify(" - ") + ", ".blue + codify(" * ") + ", or ".blue + codify(" / ") + " to return the #{original_question.formatted_class} value ".blue + required_return_value.to_s.green + ".\n".blue
  end

  def provide_evaluation_scope_with_original_variable_assignment
    evaluation_scope.eval("#{original_question.variable_name} = #{original_question.formatted_value}")
  end

  def evaluate_variable_reference_input
    enter_evaluation_loop do |user_submission|
      begin
        provide_evaluation_scope_with_original_variable_assignment
        returned_value = evaluation_scope.eval(user_submission)
        if !user_submission.include?(original_question.variable_name)
          battleprint "You didn't make use of the '#{original_question.variable_name}' variable, which is the entire purpose of this exercise. Try again.".red
        elsif user_submission.include?("=")
          battleprint "Looks like you simply assigned (or reassigned) a value to a variable, rather than making use of the value stored in '#{original_question.variable_name}'. Reread the directions and try again!".red
        elsif (returned_value == required_return_value)
          true
        else
          puts "Your code returned the #{format_class_for_output(returned_value.class)} value #{returned_value.to_s} when it should have returned the #{original_question.formatted_class} value #{format_value_for_stdout_and_eval(required_return_value)}. Try again.".red
        end
      rescue NameError, NoMethodError => e
        print_colorized_error_prompt(e)
      end
    end
  end

end
