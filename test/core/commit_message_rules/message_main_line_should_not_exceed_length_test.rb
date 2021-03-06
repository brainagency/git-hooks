require_relative '../../test_helper'

class CommitMessageRules::MessageMainLineShouldNotExceedLengthTest < Minitest::Test
  include Constants

  def commit
    @commit ||= Commit.new
  end

  def rule
    @rule ||= CommitMessageRules::MessageMainLineShouldNotExceedLength.new(commit: commit)
  end

  def test_error_message_should_be_overitten
    refute_nil rule.error_message
  end

  def test_exit_if_violated_should_return_true
    assert rule.exit_if_violated? == true
  end

  def test_violated_when_main_line_exceeds_max_length
    commit.stub :message_main_line, 'some very very long commit message which exceeds some maximum value' do
      assert rule.violated? == true
    end
  end
  
  def test_violated_when_main_line_does_not_exceed_max_length
    commit.stub :message_main_line, 'some short commit message' do
      assert rule.violated? == false
    end
  end
end
