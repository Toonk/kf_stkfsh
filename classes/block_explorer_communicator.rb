# frozen_string_literal: true

require 'date'
require 'httparty'

# Responsible for making requests to block explorer
class BlockExplorerCommunicator
  class InvalidDate < StandardError; end
  class InvalidTimeout < StandardError; end
  class TimeoutNotPositive < StandardError; end

  def initialize(date = nil, timeout = 1)
    @date = date
    @timeout = timeout
    validate_arguments
  end

  def get
    @retries = 0
    perform_get_request
  rescue Net::OpenTimeout
    return nil if @retries >= 5

    @retries += 1
    perform_get_request
  rescue Errno::ECONNREFUSED, Errno::ENETUNREACH
    nil
  end

  private

  def perform_get_request
    p "Fetching data from: #{request_url}"
    HTTParty.get(request_url, timeout: @timeout)
  end

  def request_url
    "https://chain.api.btc.com/v3/block/date/#{formatted_date}"
  end

  def formatted_date
    @date.strftime('%Y%m%d')
  end

  def validate_arguments
    validate_date
    validate_timeout
  end

  def validate_date
    raise_invalid_date unless @date.instance_of?(Date)
  end

  def validate_timeout
    raise_invalid_timeout unless [Integer, Float].include?(@timeout.class)
    raise_timeout_not_positive unless @timeout.positive?
  end

  def raise_invalid_date
    raise BlockExplorerCommunicator::InvalidDate
  end

  def raise_invalid_timeout
    raise BlockExplorerCommunicator::InvalidTimeout
  end

  def raise_timeout_not_positive
    raise BlockExplorerCommunicator::TimeoutNotPositive
  end
end
