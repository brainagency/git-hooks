module CommitMessageRules
  class DefaultCheckingProfile
    RULE_CLASSES = [
      MessageMainLineShouldNotHaveIssueNumberRule,
      MessageMainLineShouldNotExceedLengthRule,
      MessageDescriptionShouldHaveIssueCodeUnlessAnotherPartHasItRule,
      MessageShouldHaveDescriptionUnlessItIsSkippedRule,
      MessageShouldHaveDescriptionWarningRule
    ]

    def self.check(commit:, io: Kernel, exiter: Kernel)
      rule_runner = RuleRunner.new(io: io, exiter: exiter)
      RULE_CLASSES.each do |rule_class|
        rule = rule_class.new(commit: commit)
        rule_runner.run(rule: rule)
      end
    end
  end
end
