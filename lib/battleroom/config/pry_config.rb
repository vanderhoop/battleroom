Pry.config.default_window_size = 0
Pry.config.quiet = true
Pry.prompt = [proc { "> ".blue }, proc { "* ".blue }]
Pry.config.memory_size = 10
# Pry.config.coolline_matched_paren    = "\e[m"
# Pry.config.coolline_mismatched_paren    = "\e[m"

Pry::Commands.delete("exit")

Pry::Hooks.new.clear_all

Pry.config.hooks.add_hook :before_read, :exit do |last_input, pry_instance|
  # puts "last_input: #{last_input}"
  # puts "pry_instance: #{pry_instance.eval_string || nil.to_s}"
end

Pry.config.hooks.add_hook :before_eval, :self_terminate do |last_input, pry_instance|
  # puts "last_input: #{last_input}"
  # puts "pry_instance: #{pry_instance.eval_string || nil.to_s}"
  $input = last_input
  puts ''
  pry_instance.run_command("continue")
end


#======================================
# Development Helper
#======================================

# Pry.config.hooks.add_hook :before_eval, :self_terminate do |last_input, pry_instance|
#   # puts "last_input: #{last_input}"
#   # puts "pry_instance: #{pry_instance.eval_string || nil.to_s}"
#   $input = last_input
#   puts ''
#   pry_instance.run_command("continue")
# end
