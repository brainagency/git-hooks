require_relative '../../test_helper'

class CommitMessageRules::MessageDescriptionShouldHaveIssueCodeTest < Minitest::Test
  include Constants

  def commit
    @commit ||= Commit.new
  end

  def rule
    @rule ||= CommitMessageRules::MessageDescriptionShouldHaveIssueCode.new(commit: commit)
  end

  def test_error_message_should_be_overitten
    refute_nil rule.error_message
  end

  def test_exit_if_violated_should_return_true
    assert rule.exit_if_violated? == true
  end

  def test_violated_when_description_has_issue_code
    commit.stub :message_description, 'PRJ-123 some issue fix description' do
      assert rule.violated? == false
    end
  end

  def test_violated_when_description_skips_issue_code
    commit.stub :message_description, '[no-issue]' do
      assert rule.violated? == false
    end
  end

  def test_violated_when_current_branch_has_issue_code
    commit.stub :branch_name, 'PRJ-123-some-fix-branch' do
      assert rule.violated? == false
    end
  end

  def test_violated_when_no_issue_code_and_skip_label
    commit.stub :branch_name, 'some-branch' do
      assert rule.violated? == true
    end
  end
end
