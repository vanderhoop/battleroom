require_relative 'helpers/printable'
require_relative 'helpers/exceptionable'

module BattleroomMachinery
  include Battleroom::Printable
  include Battleroom::Exceptionable

  def clear_display
    `reset`
  end

  def rotate_array(array)
    item = array.shift
    array << item
  end

  def determine_variable_follow_up_question(eval_scope, question)
    if question.variable_value == true || question.variable_value == false
      VariableReassignmentQuestion.new(eval_scope, question)
    elsif question.variable_value.class == Symbol || question.variable_value.class == String
      nil
    else
      VariableReferenceQuestion.new(eval_scope, question)
    end
  end

  def naughty_input?(user_input)
    if user_input.match(/(require|`|binding)/)
      battleprint "No way no how! Try again.\n".red
      true
    else
      false
    end
  end

end
