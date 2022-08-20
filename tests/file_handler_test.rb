# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../classes/file_handler.rb'

# Tests for FileHandler
class FileHandlerTest < Minitest::Test
  def test_initialize_with_no_arguments_to_be_truthy
    assert klass_object
  end

  def test_create_and_populate_method_on_class_raises_no_method_error
    assert_raises(NoMethodError) { klass.create_and_populate }
  end

  def test_fetch_formatted_and_sorted_array_method_on_class_raises_no_method_error
    assert_raises(NoMethodError) { klass.fetch_formatted_and_sorted_array }
  end

  def test_exist_questionmark_method_on_class_raises_no_method_error
    assert_raises(NoMethodError) { klass.exist? }
  end

  def test_read_method_on_class_raises_no_method_error
    assert_raises(NoMethodError) { klass.read }
  end

  def test_create_and_populate_method_when_file_present_raises_file_already_exists
    file_handler = klass_object
    file_handler.stub(:exist?, true) do
      assert_raises(klass::FileAlreadyExists) { file_handler.create_and_populate }
    end
  end

  def test_create_and_populate_method_when_no_file_present_should_create_one
    file_handler = klass_object
    file_handler.stub(:exist?, false) do
      file_handler.stub(:generate_file, true) { assert file_handler.create_and_populate }
    end
    file_handler.stub(:exist?, true) { assert file_handler.exist? }
  end

  def test_exist_questionmark_method_should_return_false_when_no_file_present
    file_handler = klass_object
    file_handler.stub(:exist?, false) { refute file_handler.exist? }
  end

  def test_exist_questionmark_method_should_return_false_when_file_present
    file_handler = klass_object
    file_handler.stub(:exist?, true) { assert file_handler.exist? }
  end

  def test_fetch_formatted_and_sorted_array_method_should_return_blank_array
    file_handler = klass_object
    file_handler.stub(:read, '') { assert_equal [], file_handler.fetch_formatted_and_sorted_array }
  end

  def test_fetch_formatted_and_sorted_array_method_should_return_non_blank_array
    file_handler = klass_object
    file_handler.stub(:read, '1') { assert_equal [1], file_handler.fetch_formatted_and_sorted_array }
  end

  def test_read_method_with_no_file_should_return_empty_string
    File.stub(:read, ->(_file_path) { raise Errno::ENOENT }) { assert_equal '', klass_object.read }
  end

  def test_read_method_with_no_file_should_return_non_empty_string
    File.stub(:read, '1') { assert_equal '1', klass_object.read }
  end

  private

  def klass
    FileHandler
  end

  def klass_object
    klass.new
  end
end
