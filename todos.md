## Todos

- I want to keep this from happening:

    You now have the variable assignment below at your disposal.

            sum = 21.6

    Use sum in combination with an arithmetic operator like  + ,  - ,  * ,  / , or  **  to return the Fixnum value 13.600000000000001.

- Within `evaluate_variable_reference_input`, I want to check for the variable being reassigned. If the user reassigns the variable to the required return value, they're told they answered the question correctly, which they haven't.



- I want to come up with a solution for the erroring word_wrap in the method definition question: "Basically, you tried to use a method before you defined it, and Ruby said, "You haven't told me how to do that yet." To let Ruby know that
you're defining a method, you'll use the the "def" keyword, and end your method definition with the "end" keyword.
  - I've temporarily moved back to straight "puts"ing in cases where the text requires multiple lines

- String concatenation questions
- String interpolation questions
- Collection Questions
- Nested Data Structure Questions

- I want to quiet the congratulation on DataStructureAssignment questions

- I could remove the stint-length question and just roll with names (so I can use faker for a follow-up question), but then I only 

- Or I could remove the stint-length variable values that don't include 'month', 'year', or 'day', and then have users concatenate "3 months" with a dynamically generated alternative, like "and 5 years". Then, for names, have users concatenate a first name with a last name

- Or I could have the initialize method short circuit variableReferenceQuestion if it's a string.



