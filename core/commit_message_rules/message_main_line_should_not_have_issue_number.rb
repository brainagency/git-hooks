require_relative './base_rule'

module CommitMessageRules
  class MessageMainLineShouldNotHaveIssueNumber < BaseRule
    def violated?
      commit.message_main_line.match(ISSUE_REGEX) != nil
    end

    def error_message
      <<-ERROR_MSG
The main line of a commit message contains an issue number!
To fix that, please, move the issue number to the additional lines!
      ERROR_MSG
    end
  end
end
