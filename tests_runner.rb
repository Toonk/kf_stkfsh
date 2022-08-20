# frozen_string_literal: true

p 'Testing TimeBetweenTimestampsCounter'
system 'ruby tests/time_between_timestamps_counter_test.rb'

p 'Testing BlockExplorerCommunicator'
system 'ruby tests/block_explorer_communicator_test.rb'

p 'Testing BlockExplorerResponseHandler'
system 'ruby tests/block_explorer_response_handler_test.rb'

p 'Testing FileHandler'
system 'ruby tests/file_handler_test.rb'
