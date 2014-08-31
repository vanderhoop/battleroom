VARIABLE_QUESTIONS = [
  {
    possible_variable_names: [
      "num_fish",
      "num_cats",
      "num_dogs",
      "num_steaks",
      "percent_of_love_maintained",
      "fav_number",
      "days_without_rain"
    ],
    possible_variable_values: (1..100).to_a,
    value_type: "FixNum"
  },
  {
    possible_variable_names: [
      "time_abroad",
      "period_married",
      "time_passed_since_breakup",
      "time_elapsed_since_last_vacay",
      "time_elapsed_since_last_title"
    ],
    possible_variable_values: [
      "'#{rand(2..11)} months'",
      "'#{rand(2..20)} years'",
      "'#{rand(2..3)} days'"
    ],
    value_type: "String" },
  {
    possible_variable_names: [
      "instructor_name",
      "friend_for_life",
      "super_cool_name",
      "masculine_name",
      "name_for_a_nice_fellow"
    ],
    possible_variable_values: [
      "'Travis'",
      "'Phil'",
      "'PJ'",
      "'Peter'",
      "'Greg'",
      "'Yaniv'",
      "'Ben'",
      "'Jeff'",
      "'Dave'",
      "'Sammypants'",
      "'Tony'",
      "'Frost'",
    ],
    value_type: "String"
  },
]
