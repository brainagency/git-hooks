require_relative '../../test_helper'

class CommitMessageRules::MessageShouldHaveDescriptionWarningRuleTest < Minitest::Test
  include Constants

  def commit
    @commit ||= Minitest::Mock.new
  end

  def rule
    @rule ||= CommitMessageRules::MessageShouldHaveDescriptionWarningRule.new(commit: commit)
  end

  def test_error_message_should_be_overitten
    refute_nil rule.error_message
  end

  def test_exit_if_violated_should_return_false
    refute rule.exit_if_violated?
  end

  def test_violated_when_additional_lines_have_skip_label
    additional_lines = <<-LINES
    some text
    [no-desc]
    another text
    LINES
    commit.expect :additional_lines_joined, additional_lines

    assert rule.violated? == true
  end

  def test_violated_when_additional_lines_have_not_skip_label
    additional_lines = <<-LINES
    some text
    another text
    LINES
    commit.expect :additional_lines_joined, additional_lines

    assert rule.violated? == false
  end
end
