require 'test_helper'

class IpRecordTest < ActiveSupport::TestCase

  def setup
    @new_record = IpRecord.new(input: 'www.google.pl')
    @existing_record = ip_records(:hostname)
  end

  test "should be valid" do
    assert @new_record.valid?
  end

  test "input should be present" do
    @new_record.input = nil
    assert_not @new_record.valid?
  end

  test "duplicate should not be valid" do
    duplicate_record = @existing_record.dup
    assert_not duplicate_record.valid?
  end
end
