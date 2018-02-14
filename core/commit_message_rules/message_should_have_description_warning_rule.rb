require_relative './base_rule'

module CommitMessageRules
  class MessageShouldHaveDescriptionWarningRule < BaseRule
    def violated?
      commit.message_description.match(NO_DESCRIPTION_REGEX) != nil
    end

    def error_message
      <<-WARNING_MSG
I see... that you skip commit additional description... Ah okay, okay.
Despite on some specific situations, it is not recommended to skip it. Just remember this.
      WARNING_MSG
    end

    def exit_if_violated?
      false
    end
  end
end
