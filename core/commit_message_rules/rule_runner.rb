module CommitMessageRules
  class RuleRunner
    def run(rule:)
      if rule.violated?
        build_violated_result(rule)
      else
        build_not_violated_result
      end
    end

    private

    def build_not_violated_result
      RuleCheckResult.build_not_violated
    end

    def build_violated_result(rule)
      RuleCheckResult.new(
        is_violated: true,
        violation_code: rule.class::CODE,
        exit_if_violated: rule.exit_if_violated?,
        message: rule.error_message
      )
    end
  end
end
