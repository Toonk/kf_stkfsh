# frozen_string_literal: true

require 'minitest/autorun'
require 'webmock/minitest'

require_relative '../classes/block_explorer_response_handler.rb'

# Tests for BlockExplorerResponseHandler
class BlockExplorerResponseHandlerTest < Minitest::Test
  def test_initialize_with_no_arguments_raises_invalid_response
    assert_raises(klass::InvalidResponse) { klass.new }
  end

  def test_initialize_with_no_200_status_code_response_raises_response_error
    assert_raises(klass::ResponseError) { klass.new(response_stub({ status: 400 })) }
  end

  def test_initialize_with_no_success_status_in_body_response_raises_response_error
    assert_raises(klass::ResponseError) do
      klass.new(response_stub({ body: { status: 'error' }.to_json }))
    end
  end

  def test_fetch_block_timestamps_method_on_class_raises_no_method_error
    assert_raises(NoMethodError) { klass.fetch_block_timestamps }
  end

  def test_fetch_block_timestamps_method_should_return_blank_array
    response_params = { body: { data: [], status: 'success' }.to_json }
    assert_equal [], klass.new(response_stub(response_params)).fetch_block_timestamps
  end

  def test_fetch_block_timestamps_method_should_return_non_blank_array
    response_params = { body: { data: [{ timestamp: 1 }], status: 'success' }.to_json }
    assert_equal [1], klass.new(response_stub(response_params)).fetch_block_timestamps
  end

  private

  def response_stub(custom_params = {})
    return_params = { status: 200, body: '{}' }.merge(custom_params)
    stub_request(:get, request_url).to_return(return_params)
    HTTParty.get(request_url)
  end

  def request_url
    'https://chain.api.btc.com/v3/block/date/20090103'
  end

  def klass
    BlockExplorerResponseHandler
  end
end
