require_relative '../../test_helper'

class CommitMessageRules::MessageMainLineShouldNotHaveIssueNumberRuleTest < Minitest::Test
  include Constants

  def commit
    @commit ||= Commit.new
  end

  def rule
    @rule ||= CommitMessageRules::MessageMainLineShouldNotHaveIssueNumberRule.new(commit: commit)
  end

  def test_error_message_should_be_overitten
    refute_nil rule.error_message
  end

  def test_exit_if_violated_should_return_true
    assert rule.exit_if_violated? == true
  end

  def test_violated_when_main_line_has_issue_number
    commit.stub :message_main_line, 'PRJ-10 asdasd' do
      assert rule.violated? == true
    end
  end

  def test_violated_when_main_line_has_not_issue_number
    commit.stub :message_main_line, 'asdasd' do
      assert rule.violated? == false
    end
  end
end
