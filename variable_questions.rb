VARIABLE_QUESTIONS = [
  {
    var_name: [
      "num_fish",
      "num_cats",
      "num_dogs",
      "num_steaks",
      "percent_of_love_maintained"
    ],
    var_value: (1..100).to_a,
    value_type: "FixNum"
  },
  {
    var_name: [
      "time_abroad",
      "period_married",
      "time_passed_since_breakup",
      "time_elapsed_since_last_vacay",
      "time_elapsed_since_last_title"
    ],
    var_value: [
      "'#{rand(1..11)} months'",
      "'#{rand(1..20)} years'",
      "'#{rand(1..3)} days'"
    ],
    value_type: "String" },
  {
    var_name: [
      "instructor_name",
      "friend_for_life",
      "super_cool_name",
      "masculine_name",
      "name_for_a_nice_fellow"
    ],
    var_value: [
      "'Travis'",
      "'Phil'",
      "'PJ'",
      "'Peter'",
      "'Greg'",
      "'Yaniv'"
    ],
    value_type: "String"
  },
]
