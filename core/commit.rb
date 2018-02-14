require_relative './default_git_proxy'
require_relative './commit_message'

class Commit
  include Constants

  def initialize(git_proxy: DefaultGitProxy.new, raw_message: '')
    @git_proxy = git_proxy   
    @raw_message = raw_message
  end

  def message_additional_lines_joined
    message.description
  end

  def message_main_line
    message.main_line
  end

  def message
    @_message ||= CommitMessage.new(raw_message)
  end

  def branch_name
    git_proxy.current_branch_name
  end

  private

  attr_reader :git_proxy, :raw_message
end
