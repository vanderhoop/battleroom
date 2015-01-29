#!/usr/bin/env ruby

require_relative './battleroom/config/boot'

clear_display
print 'Welcome to the Battleroom.'.blue

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
      q = VariableAssignmentQuestion.new(b)
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

