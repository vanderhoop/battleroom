area_arg_one = rand(1..9)
area_arg_two = rand(1..9)
volume_arg_one = rand(1..9)
volume_arg_two = rand(1..9)
volume_arg_three = rand(1..9)
double_arg = rand(2..50)
square_arg = rand(2..12)
cube_arg = rand(2..5)
meters_to_centimeters_arg = rand(11..99)
grams_to_milligrams_arg = rand(3..11)
convert_bytes_to_bits_arg = ((6..11).to_a + [100, 1000]).sample

# values explicitly chosen to avoid values that would result in imprecise floating point arithmetic
kilograms_to_pounds_arg = [2, 4, 10, 20, 30, 1000].shuffle.sample

METHOD_QUESTONS = [
  {
    method_name: "calc_area",
    arg_count: 2,
    spec: "returns the product of its two arguments",
    eval_string: "calc_area(#{area_arg_one}, #{area_arg_two})",
    eval_answer: area_arg_one * area_arg_two
  },
  {
    method_name: "calc_volume",
    arg_count: 3,
    spec: "returns the product of its three arguments",
    eval_string: "calc_volume(#{volume_arg_one}, #{volume_arg_two}, #{volume_arg_three})",
    eval_answer: volume_arg_one * volume_arg_two * volume_arg_three
  },
  {
    method_name: "sum",
    arg_count: 2,
    spec: "returns the sum of its two arguments",
    eval_string: "sum(#{area_arg_one}, #{area_arg_two})",
    eval_answer: area_arg_one + area_arg_two
  },
  {
    method_name: "double",
    arg_count: 1,
    spec: "returns its lone argument multiplied by 2",
    eval_string: "double(#{double_arg})",
    eval_answer: double_arg * 2
  },
  {
    method_name: "triple",
    arg_count: 1,
    spec: "returns its lone argument multiplied by 3",
    eval_string: "triple(#{area_arg_two})",
    eval_answer: area_arg_two * 3
  },
  {
    method_name: "quadruple",
    arg_count: 1,
    spec: "returns its lone argument multiplied by 4",
    eval_string: "quadruple(#{area_arg_one})",
    eval_answer: area_arg_one * 4
  },
  {
    method_name: "square",
    arg_count: 1,
    spec: "returns its lone argument to the second power",
    eval_string: "square(#{square_arg})",
    eval_answer: square_arg ** 2
  },
  {
    method_name: "cube",
    arg_count: 1,
    spec: "returns its lone argument to the third power",
    eval_string: "cube(#{cube_arg})",
    eval_answer: cube_arg ** 3
  },
  {
    method_name: "kelvin_to_celsius",
    arg_count: 1,
    spec: "returns its lone argument minus the Float value \e[0;33;49m273.15\e[0m",
    eval_string: "kelvin_to_celsius(#{cube_arg})",
    eval_answer: cube_arg - 273.15
  },
  {
    method_name: "celsius_to_kelvin",
    arg_count: 1,
    spec: "returns its lone argument added to the Float value \e[0;33;49m273.15\e[0m",
    eval_string: "celsius_to_kelvin(#{square_arg})",
    eval_answer: square_arg + 273.15
  },
    {
    method_name: "kilograms_to_pounds",
    arg_count: 1,
    spec: "returns its lone argument multiplied by the Float value " + "\e[0;33;49m2.2\e[0m",
    eval_string: "kilograms_to_pounds(#{kilograms_to_pounds_arg})",
    eval_answer: kilograms_to_pounds_arg * 2.2
  },
  {
    method_name: "meters_to_centimeters",
    arg_count: 1,
    spec: "returns its lone argument multiplied by the Fixnum value " + "\e[0;33;49m100\e[0m",
    eval_string: "meters_to_centimeters(#{kilograms_to_pounds_arg})",
    eval_answer: kilograms_to_pounds_arg * 100
  },
  {
    method_name: "grams_to_milligrams",
    arg_count: 1,
    spec: "returns its lone argument multiplied by the Fixnum value 1000",
    eval_string: "grams_to_milligrams(#{grams_to_milligrams_arg})",
    eval_answer: grams_to_milligrams_arg * 1000
  },
  # {
  #   method_name: "convert_weeks_to_minutes",
  #   arg_count: 1,
  #   spec: "returns its lone argument multiplied the product of the Fixnum values 7, 24, and 60",
  #   eval_string: "grams_to_milligrams(#{grams_to_milligrams_arg})",
  #   eval_answer: grams_to_milligrams_arg * 1000
  # },
  {
    method_name: "convert_bytes_to_bits",
    arg_count: 1,
    spec: "returns its lone argument multiplied by the Fixnum value 8",
    eval_string: "convert_bytes_to_bits(#{convert_bytes_to_bits_arg})",
    eval_answer: convert_bytes_to_bits_arg * 8
  },
].shuffle
