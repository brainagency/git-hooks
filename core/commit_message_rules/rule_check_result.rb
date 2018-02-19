module CommitMessageRules
  class RuleCheckResult
    def initialize(is_violated:, violation_code:, exit_if_violated: false, message: '')
      @violated = is_violated
      @exit_if_violated = exit_if_violated
      @message = message
      @violation_code = violation_code
    end

    def self.build_not_violated
      @_not_violated_result ||= new(is_violated: false, violation_code: :no_violation)
    end

    def violated?; @violated; end

    def exit_if_violated?; @exit_if_violated; end

    def message; @message; end

    def violation_code; @violation_code; end
  end
end
