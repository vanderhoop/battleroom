Pry.config.default_window_size = 0
Pry.config.quiet = true
Pry.prompt = [proc { "> ".blue }, proc { "* ".blue }]
Pry.config.memory_size = 10

Pry::Commands.delete("exit")

Pry::Hooks.new.clear_all

Pry.config.hooks.add_hook :before_eval, :self_terminate do |last_input, pry_instance|
  $input = last_input
  puts ''
  pry_instance.run_command("continue")
end
