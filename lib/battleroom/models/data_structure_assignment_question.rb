# require_relative './data_structure_question'
# require_relative '../data/data_structure_questions'

# class DataStructureAssignmentQuestion < DataStructureQuestion
#   @questions = DATA_STRUCTURE_QUESTIONS.shuffle
#   attr_accessor :assignment_value, :assignment_key, :assignment_value_class,
#                 :formatted_assignment_value, :value_to_replace,
#                 :value_to_replace_formatted, :replacement_index,
#                 :replacement_value_class_formatted

#   def initialize(eval_scope)
#     super(eval_scope)
#     format_based_on_data_structure_class
#     self.assignment_value_class = format_class_for_output(assignment_value.class)
#   end

#   def format_based_on_data_structure_class
#     if data_structure.class == Array
#       format_array
#     else
#       format_hash
#     end
#   end

#   def format_array
#     desired_array_size = rand(3..6)
#     cull_array_to_valid_size_for_output(desired_array_size)
#     # always sets value to replace, for dev/debugging purposes
#     # if [1].sample == 1
#     if [1, 2, 3, 4, 5].sample.odd?
#       self.value_to_replace = data_structure.sample
#       self.value_to_replace_formatted = format_value_for_stdout_and_eval(value_to_replace)
#     end
#     self.assignment_value = possible_assignments.sample
#     self.formatted_assignment_value = format_value_for_stdout_and_eval(assignment_value)
#   end

#   def cull_array_to_valid_size_for_output(desired_size)
#     while data_structure.size > desired_size
#       new_assignment_possibility = data_structure.delete(data_structure.sample)
#       possible_assignments.push(new_assignment_possibility)
#     end
#   end

#   def format_hash
#     cull_hash_to_valid_size_for_output
#     assignment = possible_assignments.sample
#     self.assignment_value = assignment.values[0]
#     self.formatted_assignment_value = format_value_for_stdout_and_eval(assignment_value)
#     self.assignment_key = format_value_for_stdout_and_eval(assignment.keys[0])
#   end

#   def print_replace_array_value_prompt
#     puts "Given the data structure below, replace the #{replacement_value_class_formatted} value ".blue +
#          value_to_replace_formatted.yellow + " with the #{assignment_value_class} value ".blue +
#          formatted_assignment_value.yellow + ".\n\n"
#   end

#   def print_data_structure_assignment_prompt
#     if data_structure.class == Array
#       if value_to_replace
#         self.replacement_index = data_structure.index(value_to_replace)
#         self.replacement_value_class_formatted = format_class_for_output(value_to_replace.class)
#         print_replace_array_value_prompt
#       else
#         puts "Use an array method to add the #{assignment_value_class} value ".blue + "#{formatted_assignment_value}".yellow + " to the ".blue + "end".blue.underline + " of the Array below.\n".blue
#       end
#     else
#       puts 'Given the Hash below, add a key of '.blue + assignment_key.yellow + " that points to the #{assignment_value_class} value of ".blue + "#{formatted_assignment_value}".yellow + ".\n\n"
#     end
#     print "#{variable_name} = ".green
#     ap(data_structure, { indent: -2, index: false, multiline: true, plain: true })
#     puts ''
#   end

#   def print_resulting_data_structure
#     possible_intro_congratulations = [
#       'Brilliant',
#       'Wonderful',
#       'Jackpot',
#       'Impressive work',
#       'Bang-up job',
#       'Dynamite',
#       'Premier work',
#       'Quality work',
#       'Terrific'
#     ]
#     intro_congrat = possible_intro_congratulations.sample
#     puts "\n#{intro_congrat}. Here's the resulting data structure:\n".green
#     sleep 1.0
#     resulting_data_structure = evaluation_scope.eval(variable_name)
#     ap(resulting_data_structure, { indent: -2, index: false, multiline: true, plain: true })
#     puts ''
#     sleep 3.2
#   end

#   def handles_user_workarounds(user_input)
#     cheater_regex = Regexp.new("#{variable_name}\s+?\=\s+?(\\[)?")
#     # checks if user reassigned the variable to a new array of identical values
#     if user_input.match(cheater_regex)
#       if $1
#         puts 'You reassigned the variable to a new array object, when you could have worked with the array provided! Look up Ruby\'s Array#push method and try again!'.red
#       else
#         puts 'You reassigned the variable '.red + variable_name.green + ' rather than working with the array provided. Try again.'.red
#       end
#       puts ''
#       true
#     end
#   end

#   def handle_replacement_of_array_value_input(user_input)
#     if evaluation_scope.eval("#{variable_name}[#{replacement_index}] == #{formatted_assignment_value}") && user_input.include?(variable_name)
#       print_resulting_data_structure
#       true
#     else
#       puts "\nNope! Here's what the data stucture would look like given your code:\n".red
#       resulting_data_structure = evaluation_scope.eval(variable_name)
#       ap(resulting_data_structure, { indent: -2, index: false, multiline: true, plain: true })
#       puts "\nCheck your index and assignment values and try again.\n".red
#     end
#   end

#   def evaluate_user_input_for_array_questions(user_input)
#     if handles_user_workarounds(user_input)
#       false
#     end
#     if value_to_replace
#       handle_replacement_of_array_value_input(user_input)
#     elsif evaluation_scope.eval("#{variable_name}.last == #{formatted_assignment_value}") && user_input.include?(variable_name)
#       print_resulting_data_structure
#       true
#     else
#       puts 'Nope! Try again.'.red
#     end
#   end

#   def evaluate_user_input_for_hash_questions(user_input)
#     if evaluation_scope.eval("#{variable_name}[#{assignment_key}] == #{formatted_assignment_value}") && user_input.include?(variable_name)
#       print_resulting_data_structure
#       true
#     else
#       puts 'Nope! Try again!'.red
#     end
#   end

#   def evaluate_data_structure_assignment_input
#     enter_evaluation_loop do |user_input|
#       begin
#         # provides the evaluation scope with variable assignment necessary for answer eval
#         evaluation_scope.eval("#{variable_name} = #{data_structure.to_s}")
#         evaluation_scope.eval(user_input)
#         if data_structure.class == Array
#           evaluate_user_input_for_array_questions(user_input)
#         else
#           evaluate_user_input_for_hash_questions(user_input)
#         end
#       rescue NoMethodError, NameError => e
#         print_colorized_error_prompt(e)
#       rescue TypeError => e
#         print_colorized_type_error_prompt(e)
#       end
#     end
#   end

# end
