require_relative '../test_helper'

class CommitTest < Minitest::Test
  def test_branch_name_has_issue_number_when_branch_contains_it
    mocked_git_proxy = Minitest::Mock.new
    def mocked_git_proxy.current_branch_name; "#{GIT_HOOKS_PROJECT_CODE}-123"; end

    commit = Commit.new(git_proxy: mocked_git_proxy)

    assert commit.branch_name_has_issue_number?
  end

  def test_branch_name_has_issue_number_when_branch_does_not_contain_it
    mocked_git_proxy = Minitest::Mock.new
    def mocked_git_proxy.current_branch_name; "NO-123"; end

    commit = Commit.new(git_proxy: mocked_git_proxy)

    refute commit.branch_name_has_issue_number?
  end
end
