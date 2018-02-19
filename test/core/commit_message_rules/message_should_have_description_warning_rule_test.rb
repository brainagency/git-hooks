require_relative '../../test_helper'

class CommitMessageRules::MessageShouldHaveDescriptionWarningRuleTest < Minitest::Test
  include Constants

  def commit
    @commit ||= Commit.new
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

  def test_violated_when_description_have_skip_label
    description = <<-LINES
    some text
    [no-desc]
    another text
    LINES

    commit.stub :message_description, description do
      assert rule.violated? == true
    end
  end

  def test_violated_when_description_have_not_skip_label
    description = <<-LINES
    some text
    another text
    LINES
    commit.stub :message_description, description do
      assert rule.violated? == false
    end
  end

  def test_violation_code
    assert rule.class.violation_code == :message_should_have_description_warning
  end
end
