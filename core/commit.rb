class Commit
  include Constants

  def branch_name
    `git rev-parse --abbrev-ref HEAD`
  end

  def branch_name_has_issue_number?
    branch_name.match ISSUE_REGEX
  end
end
