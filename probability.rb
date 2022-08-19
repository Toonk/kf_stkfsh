# frozen_string_literal: true

# ruby 3.1.2

# How often does the Bitcoin network see two consecutive blocks mined more than 2 hours apart from each other?
# We'd like to know your answer (it doesn't have to be precise) and your approach towards this solution using
# probability and statistics.

# https://en.wikipedia.org/wiki/Gamma_function
# Bitcoin expected block time is 10 minutes -> 6 blocks per hour
# Ruby Math module has no factorial(n) method, but has a gamma(n+1) method that is equal

# https://en.wikipedia.org/wiki/Poisson_distribution
# Poisson distribution
# probability = (occurences_in_time ** number_of_occurrences * eulers_number ** -occurences_in_time) /
#               Math.gamma(number_of_occurrences + 1)

occurrences_per_hour = 6
number_of_hours = 2
occurences_in_time = occurrences_per_hour * number_of_hours
eulers_number = Math.exp(1)
probability_of_no_occurences = eulers_number**-occurences_in_time

frequency_in_hours = 1 / (6 * probability_of_no_occurences)
frequency_in_minutes = frequency_in_hours * 60
frequency_in_seconds = frequency_in_minutes * 60
frequency_in_miliseconds = frequency_in_seconds * 1000
frequency_in_days = frequency_in_hours / 24
frequency_in_months = frequency_in_days / 30
frequency_in_years = frequency_in_days / 365

p 'Probability of two consecutive blocks mined more than 2 hours apart from each other ' \
  "#{probability_of_no_occurences}"
p 'Event where time between two consecutive blocks in the Bitcoin network will be greater ' \
  'than 2 hours should occr once every:'
p "~#{frequency_in_miliseconds.round(2)} miliseconds"
p "~#{frequency_in_seconds.round(2)} seconds"
p "~#{frequency_in_minutes.round(2)} minutes"
p "~#{frequency_in_hours.round(2)} hours"
p "~#{frequency_in_days.round(2)} days"
p "~#{frequency_in_months.round(2)} months (30 days in a month)"
p "~#{frequency_in_years.round(2)} years (365 days in a year)"
