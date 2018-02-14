require_relative '../test_helper'

class CommitMessageTest < Minitest::Test
  def test_additional_lines_joined_when_raw_message_is_blank
    message = CommitMessage.new('')

    assert message.additional_lines_joined.empty? == true
  end

  def test_main_line_when_raw_message_is_blank
    message = CommitMessage.new('')

    assert message.main_line.empty? == true
  end
end
