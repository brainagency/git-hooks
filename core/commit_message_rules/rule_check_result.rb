module CommitMessageRules
  class RuleCheckResult
    NO_VIOLATION = :no_violation

    attr_reader :message, :violation_code

    def initialize(is_violated:, violation_code:, exit_if_violated: false, message: '')
      @violated = is_violated
      @exit_if_violated = exit_if_violated
      @message = message
      @violation_code = violation_code
    end

    def self.build_not_violated
      @build_not_violated ||= new(
        is_violated: false, violation_code: NO_VIOLATION
      )
    end

    def violated?
      @violated
    end

    def exit_if_violated?
      @exit_if_violated
    end
  end
end
