module CommitMessageRules
  class DefaultCheckingProfile
    RULE_CLASSES = [
      MessageMainLineShouldNotHaveIssueNumberRule,
      MessageMainLineShouldNotExceedLengthRule,
      MessageDescriptionShouldHaveIssueCodeUnlessAnotherPartHasItRule,
      MessageShouldHaveDescriptionUnlessItIsSkippedRule,
      MessageShouldHaveDescriptionWarningRule
    ]

    def self.check(commit:)
      rule_runner = RuleRunner.new
      RULE_CLASSES.each do |rule_class|
        rule = rule_class.new(commit: commit)
        check_result = rule_runner.run(rule: rule)
        return check_result if check_result.violated?
      end
      RuleCheckResult.build_not_violated
    end
  end
end
