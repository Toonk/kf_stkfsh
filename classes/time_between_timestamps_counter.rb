# frozen_string_literal: true

SECONDS_IN_2_HOURS = 7200

# Responsible for calculating the number of two consecutive blocks mined more than #{time_difference}
# seconds from each other in the Bitcoin network
class TimeBetweenTimestampsCounter
  class InvalidArray < StandardError; end
  class InvalidArrayData < StandardError; end
  class InvalidTimeDifference < StandardError; end

  def initialize(array = [], time_difference = SECONDS_IN_2_HOURS)
    @count = 0
    @time_difference = time_difference
    @array = array
    validate_attributes
  end

  def count
    @array.length.times do |i|
      next if (next_element = @array[i + 1]).nil?

      @count += 1 if (next_element - @array[i]) > @time_difference
    end
    @count
  end

  private

  def validate_attributes
    validate_array
    validate_time_difference
  end

  def validate_array
    raise_invalid_array unless @array.instance_of?(Array)
    raise_invalid_array_data if @array.length.positive? && !@array.first.instance_of?(Integer)
  end

  def validate_time_difference
    raise_invalid_time_difference unless @time_difference.instance_of?(Integer)
  end

  def raise_invalid_array
    raise TimeBetweenTimestampsCounter::InvalidArray
  end

  def raise_invalid_array_data
    raise TimeBetweenTimestampsCounter::InvalidArrayData
  end

  def raise_invalid_time_difference
    raise TimeBetweenTimestampsCounter::InvalidTimeDifference
  end
end
