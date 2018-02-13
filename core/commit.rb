require_relative './default_git_proxy'
require_relative './commit_message'

class Commit
  include Constants

  def initialize(git_proxy: DefaultGitProxy.new, raw_message: '')
    @git_proxy = git_proxy   
    @raw_message = raw_message
  end

  def branch_name_has_issue_number?
    branch_name.match(ISSUE_REGEX) != nil
  end

  def message
    @_message ||= CommitMessage.new(raw_message)
  end

  private

  attr_reader :git_proxy, :raw_message

  def branch_name
    git_proxy.current_branch_name
  end
end
