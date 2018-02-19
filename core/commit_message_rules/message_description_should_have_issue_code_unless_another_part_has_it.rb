require_relative './base_rule'

module CommitMessageRules
  class MessageDescriptionShouldHaveIssueCodeUnlessAnotherPartHasIt < BaseRule
    def violated?
      description_has_not_issue_code? &&
        description_does_not_skip_issue_code? &&
        current_branch_has_not_issue_code_in_name?
    end

    def error_message
      <<-ERROR_MSG
The additional lines do not contain the issue code!
Please, make sure to mark commit with it!
      ERROR_MSG
    end

    private

    def description_has_not_issue_code?
      commit.message_description.match(ISSUE_REGEX) == nil
    end

    def description_does_not_skip_issue_code?
      commit.message_description.match(NO_ISSUE_REGEX) == nil
    end

    def current_branch_has_not_issue_code_in_name?
      commit.branch_name.match(ISSUE_REGEX) == nil
    end
  end
end
