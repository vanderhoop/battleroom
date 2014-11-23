area_arg_one = rand(1..9)
area_arg_two = rand(1..9)
volume_arg_one = rand(1..9)
volume_arg_two = rand(1..9)
volume_arg_three = rand(1..9)

METHOD_QUESTONS = [
  # {
  #   method_name: "calc_area",
  #   arg_count: 2,
  #   spec: "returns the product of its two arguments",
  #   eval_string: "calc_area(#{area_arg_one}, #{area_arg_two})",
  #   eval_answer: area_arg_one * area_arg_two
  # },
  # {
  #   method_name: "calc_volume",
  #   arg_count: 3,
  #   spec: "returns the product of its three arguments",
  #   eval_string: "calc_volume(#{volume_arg_one}, #{volume_arg_two}, #{volume_arg_three})",
  #   eval_answer: volume_arg_one * volume_arg_two * volume_arg_three
  # },
  # {
  #   method_name: "sum",
  #   arg_count: 2,
  #   spec: "returns the sum of its two arguments",
  #   eval_string: "sum(#{area_arg_one}, #{area_arg_two})",
  #   eval_answer: area_arg_one + area_arg_two
  # },
  {
    method_name: "double",
    arg_count: 1,
    spec: "returns the product of 2 and whatever Fixnum value is passed in as its lone argument",
    eval_string: "double(#{area_arg_one})",
    eval_answer: area_arg_one * 2
  },
  {
    method_name: "triple",
    arg_count: 1,
    spec: "returns the product of 3 and whatever Fixnum value is passed in as its lone argument",
    eval_string: "triple(#{area_arg_one})",
    eval_answer: area_arg_one * 3
  },
  {
    method_name: "quadruple",
    arg_count: 1,
    spec: "returns the product of 4 and whatever Fixnum value is passed in as its lone argument",
    eval_string: "quadruple(#{area_arg_one})",
    eval_answer: area_arg_one * 4
  },
  {
    method_name: "cube",
    arg_count: 1,
    spec: "returns the product of 4 and whatever Fixnum value is passed in as its lone argument",
    eval_string: "quadruple(#{area_arg_one})",
    eval_answer: area_arg_one * 4
  },
]
