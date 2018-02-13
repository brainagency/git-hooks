require_relative './base_rule'

module CommitMessageRules
  class MessageMainLineShouldNotExceedLengthRule < BaseRule
    def violated?
      commit.message_main_line.length > MAIN_LINE_MAX_LENGTH
    end

    def error_message
      <<-ERROR_MSG
The main line's length exceeds a threshold which is #{MAIN_LINE_MAX_LENGTH} characters!"
Please, make a commit message more brief!"
Git does not preserve a commit messages which exceeds #{MAIN_LINE_MAX_LENGTH} characters in length!"
      ERROR_MSG
    end
  end
end
