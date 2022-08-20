# frozen_string_literal: true

require 'date'

require_relative 'block_explorer_communicator.rb'
require_relative 'block_explorer_response_handler.rb'

GENESIS_BLOCK_DATE = Date.parse('2009-01-03').freeze
FILE_LOCATION = './'
FILE_NAME = 'list_of_block_timestamps.txt'

# Responsible for handling ./list_of_blocks.txt file
class FileHandler
  class FileAlreadyExists < StandardError; end

  def initialize
    @dates = (GENESIS_BLOCK_DATE..Date.today).to_a
    empty_arrays
  end

  def create_and_populate
    return raise_file_already_exists if exist?

    generate_file
  end

  def exist?
    File.exist?(path_to_file)
  end

  def fetch_formatted_and_sorted_array
    read.gsub("\n", ',').split(',').uniq.map(&:to_i)
  end

  def read
    File.read(path_to_file)
  rescue Errno::ENOENT
    ''
  end

  private

  def empty_arrays
    @block_timestamps = []
    @failed = []
  end

  def generate_file
    process_dates_array
    retry_failed_datetimes unless @failed.empty? # just one retry
  end

  def process_dates_array(dates = @dates, timeout = 1)
    dates.each_slice(30) do |sliced_dates|
      @block_timestamps = []
      fetch_block_timestamps(sliced_dates, timeout)
      write_to_file
    end
  end

  def fetch_block_timestamps(dates = [], timeout = 1)
    dates.each do |date|
      begin
        process_date(date, timeout)
      rescue BlockExplorerCommunicator::InvalidTimeout, BlockExplorerCommunicator::TimeoutNotPositive,
             BlockExplorerCommunicator::InvalidDate, BlockExplorerResponseHandler::InvalidResponse,
             BlockExplorerResponseHandler::ResponseError
        print_failure_and_append_array(date)
        next
      end
    end
  end

  def process_date(date, timeout)
    response = BlockExplorerCommunicator.new(date, timeout).get
    @block_timestamps |= BlockExplorerResponseHandler.new(response).fetch_block_timestamps
  end

  def print_failure_and_append_array(date)
    p "#{date} failed!"
    @failed << date
  end

  def write_to_file
    p 'Writing to file!'
    File.write(path_to_file, formatted_content, mode: 'a')
  end

  def retry_failed_dates
    old_failed = @failed
    empty_arrays
    process_dates_array(old_failed, 3)
    write_to_file
  end

  def path_to_file
    "#{FILE_LOCATION}#{FILE_NAME}"
  end

  def formatted_content
    "#{@block_timestamps.join("\n")}\n"
  end

  def raise_file_already_exists
    raise FileHandler::FileAlreadyExists
  end
end
