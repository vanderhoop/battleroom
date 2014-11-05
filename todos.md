## Todos

- I want to create two methods for customization resetting the configuration for Pry, which is currently set to auto-escape after one eval.

- I want to add additional advice to users who try to invoke methods with the parameters used in their method defintiion.

__Example:__ 
```ruby
def calc_area(x, y)
  x*y
end

# misguided invocation
calc_area(x,y)

# I'd like to alert users to their misunderstanding
```

- I want to add follow up questions to variable assignment, to hammer home the idea that variables store a reference to an object in memory. Look for common language explanations.

- I want to make sure the line of the terminal wraps so that words aren't broken up, slash truncated

