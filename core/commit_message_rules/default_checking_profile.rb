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
      RULE_CLASSES.each do |rule_class|
        rule = rule_class.new(commit: commit)
        RuleRunner.run(rule: rule, io: io, exiter: exiter)
      end
    end
  end
end
