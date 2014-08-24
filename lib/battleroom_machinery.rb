module BattleroomMachinery

  def clear_display
    `reset`
  end

  def random_congratulation
    ["Lovely work, my friend!\n", "Beautiful!\n", "Lovely!\n", "Splendid!\n", "Nice job! Keep it rolling!\n", "Capital work, battlestar!\n", "You're on your way!\n", "Exemplary work!\n", "Yeah!\n", "Roll on.\n", "You're making a prosperous go of this programming thing.\n", "Bullseye!\n"].sample
  end

  def print_prompt_with_options
    puts "What would you like to work on?".blue
    puts "1. Variable assignment"
    puts "2. Accessing values from arrays/hashes"
    puts "Q. Quit\r\n\n"
  end

end
