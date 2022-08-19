# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../classes/time_between_timestamps_counter.rb'

# Tests for TimeBetweenTimestampsCounter
class TimeBetweenTimestampsCounterTest < Minitest::Test
  def test_initialize_with_no_arguments_to_be_truthy
    assert klass.new
  end

  def test_initialize_with_invalid_array_raises_invalid_array
    assert_raises(klass::InvalidArray) { klass.new('array') }
  end

  def test_initialize_with_invalid_array_data_raises_invalid_array_data
    assert_raises(klass::InvalidArrayData) { klass.new(['array']) }
  end

  def test_initialize_with_invalid_time_difference_raises_invalid_time_difference
    assert_raises(klass::InvalidTimeDifference) { klass.new([], 'time_difference') }
  end

  def test_calculate_solution_method_on_class_raises_no_method_error
    assert_raises(NoMethodError) { klass.calculate_solution }
  end

  def test_calculate_solution_method_with_empty_array_should_return_0
    assert_equal 0, klass.new.calculate_solution
  end

  def test_calculate_solution_method_with_one_element_array_should_return_0
    assert_equal 0, klass.new([0]).calculate_solution
  end

  def test_calculate_solution_method_should_return_0
    assert_equal 0, klass.new([0, 7200]).calculate_solution
  end

  def test_calculate_solution_method_should_return_1
    assert_equal 1, klass.new([0, 7201]).calculate_solution
  end

  private

  def klass
    TimeBetweenTimestampsCounter
  end
end
