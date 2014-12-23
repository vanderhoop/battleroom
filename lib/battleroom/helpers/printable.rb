module Battleroom
  module Printable

    CONGRATULATIONS = [
      'Lovely work, my friend!',
      'Beautiful!',
      'Lovely!',
      'Splendid!',
      'Awesome.',
      'Stand up job, my friend.',
      'Nailed it.',
      'Nice job! Keep it rolling!',
      'Capital work, battlestar!',
      'Exemplary work!',
      'Yeah!',
      'Roll on.',
      'Bullseye!',
      'Woo!',
      'Let it ride!',
      'Touchdown!',
      "You're on your way!",
      "You're making a prosperous go of this programming thing.",
    ]

    def print_menu_options
      battleprint ' What would you like to work on?'.blue
      battleprint '1. Working with Variables'
      battleprint '2. Accessing Values in Arrays and Hashes'
      battleprint '3. Adding Values to Arrays and Hashes'
      battleprint '4. Working with Methods'
      battleprint "Q. Quit\r\n\n"
    end

    def random_congratulation
      CONGRATULATIONS.sample
    end

    def print_congratulation
      battleprint "\n#{random_congratulation}\n".green
    end

    def indent_all_lines_for_stdout(string_to_indent)
      string_to_indent.gsub(/^.*/) { |match| "\t" + match }
    end

    def dynamic_word_wrap(string)
      string.wrap(150)
    end

    def battleprint(string)
      puts dynamic_word_wrap(string)
    end

    def format_value_for_stdout_and_eval(object)
      case object.class.to_s
      when 'String'
        if object.include?("'")
          '"' + object + '"'
        else
          "'#{object}'"
        end
      when 'Symbol' then return ":#{object}"
      else
        object.to_s
      end
    end

    def format_class_for_output(klass)
      return 'Boolean' if klass.to_s.match /(TrueClass|FalseClass)/
      klass.to_s
    end

  end
end
