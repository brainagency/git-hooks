require_relative './base_rule'

module CommitMessageRules
  class MessageDescriptionShouldHaveIssueCode < BaseRule
    def violated?
      return false if skipped?
      description_has_not_issue_code? && current_branch_has_not_issue_code_in_name?
    end

    def error_message
      <<-ERROR_MSG
The additional lines do not contain the issue code!
Please, make sure to mark commit with it!
      ERROR_MSG
    end

    private

    def skipped?
      description_has_skip_issue_code_label?
    end

    def description_has_skip_issue_code_label?
      commit.message_description.match(NO_ISSUE_REGEX) != nil
    end

    def description_has_not_issue_code?
      commit.message_description.match(ISSUE_REGEX) == nil
    end


    def current_branch_has_not_issue_code_in_name?
      commit.branch_name.match(ISSUE_REGEX) == nil
    end
  end
end
