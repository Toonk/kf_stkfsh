# frozen_string_literal: true

require_relative 'classes/time_between_timestamps_counter.rb'
require_relative 'classes/file_handler.rb'

begin
  file_handler = FileHandler.new
  file_handler.create_and_populate unless file_handler.exist?
  formatted_array = file_handler.fetch_formatted_and_sorted_array
  solution = TimeBetweenTimestampsCounter.new(formatted_array).count
  p 'The number of two consecutive blocks mined more than 2 hours apart from each other in the ' \
      "Bitcoin network is: #{solution}"
rescue TimeBetweenTimestampsCounter::InvalidArray, TimeBetweenTimestampsCounter::InvalidArrayData,
       TimeBetweenTimestampsCounter::InvalidTimeDifference
  p 'Could not finish task! TimeBetweenTimestampsCounter was initialized with invalid data!'
end
