## Todos

- I want to look over the variable assignment questions and try to identify ways in which I can add a follow up question 

- I want to keep this from happening:

    You now have the variable assignment below at your disposal.

            unlucky_number = 44

    Use unlucky_number in combination with an arithmetic operator like  + ,  - ,  * ,  / , or  **  to return the Fixnum value 43.

    > unlucky_number = 44
    Your code returned the Fixnum value 44 when it should have returned the Fixnum value 44. Try again.
    > 

- I need to write exception handlers for VariableReassignmentQuestion

- I want to refactor all things having to do with errors

- I want to come up with a solution for the erroring word_wrap in the method definition question: "Basically, you tried to use a method before you defined it, and Ruby said, "You haven't told me how to do that yet." To let Ruby know that
you're defining a method, you'll use the the "def" keyword, and end your method definition with the "end" keyword.
  - I've temporarily moved back to straight "puts"ing in cases where the text requires multiple lines

- I want to add follow up questions to variable assignment, to hammer home the idea that variables store a reference to an object in memory. Look for common language explanations.

- I want to write tests for the the variable question data.

- I want to quiet the congratulation on DataStructureAssignment questions

- I could remove the stint-length question and just roll with names (so I can use faker for a follow-up question), but then I only 

- Or I could remove the stint-length variable values that don't include 'month', 'year', or 'day', and then have users concatenate "3 months" with a dynamically generated alternative, like "and 5 years". Then, for names, have users concatenate a first name with a last name

- Or I could have the initialize method short circuit variableReferenceQuestion if it's a string.



