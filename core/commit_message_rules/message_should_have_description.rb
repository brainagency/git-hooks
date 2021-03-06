require_relative './base_rule'

module CommitMessageRules
  class MessageShouldHaveDescription < BaseRule
    def violated?
      return false if skipped?
      description_is_absent?
    end

    def error_message
      <<-ERROR_MSG
There is no additional description found!
Commit message main line's length is very short to contain a full list of the details about
what this commit provides. So be free to add some additional lines to describe the commit!
      ERROR_MSG
    end

    private

    def skipped?
      description_has_skip_label?
    end

    def description_has_skip_label?
      commit.message_description.match(NO_DESCRIPTION_REGEX) != nil
    end

    def description_is_absent?
      length_of_just_description = commit.message_description
        .gsub(ISSUE_REGEX, '')
        .gsub(NO_ISSUE_REGEX, '')
        .chomp.strip.length
      length_of_just_description < LENGTH_OF_DESCRIPTION_THRESHOLD
    end
  end
end
