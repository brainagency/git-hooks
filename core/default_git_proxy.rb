class DefaultGitProxy
  def current_branch_name
    `git rev-parse --abbrev-ref HEAD`
  end
end
