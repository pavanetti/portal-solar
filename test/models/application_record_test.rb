require 'test_helper'

class ApplicationRecordTest < ActiveSupport::TestCase
  test 'should exec scope body when passed an argument' do
    @has_called = false
    PowerGenerator.effectless_scope :a_uniq_name, -> (arg) { @has_called = true }
    PowerGenerator.a_uniq_name 'arg'
    assert(@has_called)
  end

  test 'should not exec scope body when passed an empty argument' do
    @has_called = false
    PowerGenerator.effectless_scope :a_uniq_name, -> (arg) { @has_called = true }
    PowerGenerator.a_uniq_name ''
    assert(!@has_called)
  end
end
