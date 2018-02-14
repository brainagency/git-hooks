require_relative '../../test_helper'

class CommitMessageRules::MessageShouldHaveDescriptionUnlessItIsSkippedRuleTest < Minitest::Test
  def commit
    @commit ||= Commit.new
  end

  def rule
    @rule ||= CommitMessageRules::MessageShouldHaveDescriptionUnlessItIsSkippedRule.new(commit: commit)
  end

  def test_error_message_should_be_overitten
    refute_nil rule.error_message
  end

  def test_exit_if_violated_should_return_true
    assert rule.exit_if_violated? == true
  end

  def test_violated_when_description_is_skipped
    commit.stub :message_additional_lines_joined, '[no-desc]' do
      assert rule.violated? == false
    end
  end

  def test_violated_when_description_is_not_skipped_and_empty
    commit.stub :message_additional_lines_joined, '     ' do
      assert rule.violated? == true
    end
  end

  def test_violated_when_description_is_not_skipped_and_not_empty
    commit.stub :message_additional_lines_joined, 'some very long long commit description' do
      assert rule.violated? == false
    end
  end
end
