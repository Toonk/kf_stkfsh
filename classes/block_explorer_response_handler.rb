# frozen_string_literal: true

require 'httparty'

# Responsible for handling responses from BlockExplorerCommunicator
class BlockExplorerResponseHandler
  class InvalidResponse < StandardError; end
  class ResponseError < StandardError; end

  def initialize(response = nil)
    @response = response
    @timestamps = []
    validate_and_parse_response
  end

  def fetch_block_timestamps
    @parsed_data.each { |block_data| @timestamps << fetch_timestamp_from_block_data(block_data) }
    @timestamps.compact
  end

  private

  def validate_and_parse_response
    raise_invalid_response unless @response.instance_of?(HTTParty::Response)
    parse_response_data
    raise_response_error unless @response.code == 200 && @parsed_response.dig('status') == 'success'
    @parsed_data = [] if @parsed_data&.count.nil?
  end

  def parse_response_data
    @parsed_response = JSON.parse(@response.body)
    @parsed_data = @parsed_response.dig('data')
  end

  def fetch_timestamp_from_block_data(block_data)
    block_data.dig('timestamp')
  end

  def raise_invalid_response
    raise BlockExplorerResponseHandler::InvalidResponse
  end

  def raise_response_error
    raise BlockExplorerResponseHandler::ResponseError
  end
end
