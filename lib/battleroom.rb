#!/usr/bin/env ruby

require_relative './battleroom/config/boot'

clear_display
print 'Welcome to the Battleroom.'.blue

VARIABLE_QUESTIONS.shuffle!
ARRAY_QUESTIONS.shuffle!
HASH_QUESTIONS.shuffle!
VARIABLE_QUESTIONS.shuffle!

loop do
  print_menu_options
  choice = Readline.readline('> '.blue, true)
  abort('Goodbye!'.green) if choice.match(/^(q|exit|!!!\s?)/i)
  clear_display

  # for eval
  b = binding

  case choice
  when '1'
    10.times do
      question_data = rotate_array(VARIABLE_QUESTIONS).first
      q = VariableAssignmentQuestion.new(
        question_data: question_data,
        evaluation_scope: b,
        printer: VariableAssignmentPrinter.new
      )
      restore_pry_defaults
      binding.pry
      determine_variable_follow_up_question(b, q)
    end
  when '2'
    5.times do
      q = [ArrayAccessQuestion.new(b), HashAccessQuestion.new(b)].sample
    end
  when '3'
    5.times do
      q = [ArrayAssignmentQuestion.new(b), HashAssignmentQuestion.new(b)].sample
    end
  when '4'
    5.times do
      q = MethodDefinitionQuestion.new(b)
      follow_up_question = MethodInvocationQuestion.new(b, q)
    end
  when '5'
    5.times { NestedDataStructureAccessQuestion.new(b) }
  else
    battleprint 'You entered a non-option. Try again.'.red
  end
end

