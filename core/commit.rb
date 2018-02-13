require_relative './default_git_proxy'

class Commit
  include Constants

  def initialize(git_proxy: DefaultGitProxy.new)
    @git_proxy = git_proxy   
  end

  def branch_name
    git_proxy.current_branch_name
  end

  def branch_name_has_issue_number?
    branch_name.match(ISSUE_REGEX) != nil
  end

  private

  attr_reader :git_proxy
end
