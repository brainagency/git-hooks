module CommitMessageRules
  #
  # Checks commit message text and its format
  #
  # In order to:
  #   * make commit messages more standartized
  #   * make commit message to tell what this particular commit provides
  #   * make commit message more convenient for the other developers
  # the following rules will be applied:
  #   * main line MUST to not contain issue number.
  #     Mostly issue number is useful for the tickets systems, CI systems and others, but not for
  #     developers. Actually issue number takes a lot of space, which is not so big, to write
  #     meaningful commit description, because mostly everywhere git shows only this first line.
  #   * main line MUST has length not more than 50 characters.
  #     Of course you can write more, but only 50 characters will be showen, for example, in the
  #     bitbucket and other systems.
  #   * additional lines MUST has issue number OR `[no-issue]` label
  #     In order to allow specialized systems to link commits and issues. If you do not want that,
  #     just add `[no-issue]` label.
  #   * additional lines MUST has more detailed description about what this commit carries inside
  #     For example: what was the problem and what is a solution, what has been improved and so on.
  #
  class DefaultCheckingProfile
    RULE_CLASSES = [
      MessageMainLineShouldNotHaveIssueNumber,
      MessageMainLineShouldNotExceedLength,
      MessageDescriptionShouldHaveIssueCode,
      MessageShouldHaveDescription,
      MessageShouldHaveDescriptionWarning
    ].freeze

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
