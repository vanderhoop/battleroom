# eliminates deprecation warning
I18n.config.enforce_available_locales = false

def configure_pry
  Pry.config.default_window_size = 0
  Pry.config.quiet = true
  Pry.prompt = [
    proc { "> ".blue },
    proc { "* ".blue }
  ]
  Pry.config.memory_size = 10

  # removes pry's exit command, which is run before any of the before_eval hooks, resulting in a pry session users can't escape
  Pry::Commands.delete("exit")

  # # quiets pry error caused by self_termination (below)
  Pry.config.exception_handler = proc { |output, exception, _| }

  # short circuits pry REPL before eval, saving eval for Question
  Pry.config.hooks.add_hook :before_eval, :self_terminate do |last_input, pry_instance|
    begin
      # exports user input for availability
      $input = last_input
      unless last_input.include?("restore_pry_defaults")
        pry_instance.run_command("continue")
      end
    # quiets ArgumentError thrown by pry-byebug as a result of self_termination hook (above)
    rescue ArgumentError
    end
  end
end

# for use in debugging
def restore_pry_defaults
  Pry.config.default_window_size = 15
  Pry.config.quiet = false
  Pry.prompt = Pry::DEFAULT_PROMPT
  Pry.config.hooks.delete_hook :before_eval, :self_terminate
end

if RUBY_ENGINE == 'ruby' && RUBY_VERSION >= '1.9.3' && RUBY_VERSION <= '2.1.2'
  PRY_DEBUGGER_GEM ||= 'pry-debugger'
else
  PRY_DEBUGGER_GEM ||= 'pry-byebug'
end

tries = 0
begin
  require PRY_DEBUGGER_GEM
rescue LoadError
  if (tries += 1) > 2
    $stderr.puts "Could not install pry debugger gem: #{PRY_DEBUGGER_GEM}, continuing anyhow."
    raise
  end
  require 'rubygems/dependency_installer'
  $stderr.puts "Auto installing pry debugger: #{PRY_DEBUGGER_GEM}"
  Gem::DependencyInstaller.new.install(PRY_DEBUGGER_GEM)
  retry
end

configure_pry
