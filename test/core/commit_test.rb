require_relative '../test_helper'

class CommitTest < Minitest::Test
  def mocked_git_proxy
    @_mocked_git_proxy ||= Minitest::Mock.new
  end

  def test_branch_name_has_issue_number_when_branch_contains_it
    mocked_git_proxy.expect :current_branch_name, "#{GIT_HOOKS_PROJECT_CODE}-123"

    commit = Commit.new(git_proxy: mocked_git_proxy)

    assert commit.branch_name_has_issue_number?
  end

  def test_branch_name_has_issue_number_when_branch_does_not_contain_it
    mocked_git_proxy.expect :current_branch_name, "NO-123"

    commit = Commit.new(git_proxy: mocked_git_proxy)

    refute commit.branch_name_has_issue_number?
  end

  def test_message_provides_wrapped_raw_message
    commit = Commit.new(raw_message: 'Some commit message')

    assert commit.message.is_a?(CommitMessage)
  end
end
