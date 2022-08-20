# frozen_string_literal: true

require 'minitest/autorun'
require 'webmock/minitest'

require_relative '../classes/block_explorer_communicator.rb'

# Tests for BlockExplorerCommunicator
class BlockExplorerCommunicatorTest < Minitest::Test
  def test_initialize_with_no_arguments_raises_invalid_date
    assert_raises(klass::InvalidDate) { klass.new }
  end

  def test_initialize_with_invalid_date_raises_invalid_date
    assert_raises(klass::InvalidDate) { klass.new('date') }
  end

  def test_initialize_with_invalid_timeout_raises_invalid_timeout
    assert_raises(klass::InvalidTimeout) { klass.new(Date.today, '1') }
  end

  def test_initialize_with_negative_timeout_raises_timeout_not_positive
    assert_raises(klass::TimeoutNotPositive) { klass.new(Date.today, -1) }
  end

  def test_initialize_with_zero_timeout_raises_timeout_not_positive
    assert_raises(klass::TimeoutNotPositive) { klass.new(Date.today, 0) }
  end

  def test_initialize_with_no_timeout_to_be_truthy
    assert klass.new(Date.today)
  end

  def test_initialize_with_correct_attributes_to_be_truthy
    assert klass.new(Date.today, 1)
  end

  def test_get_method_on_class_raises_no_method_error
    assert_raises(NoMethodError) { klass.get }
  end

  def test_get_method_to_respond_with_code_200
    stub_request(:get, 'https://chain.api.btc.com/v3/block/date/20090103')
    assert_equal 200, klass.new(Date.parse('2009-01-03')).get.code
  end

  private

  def klass
    BlockExplorerCommunicator
  end
end
