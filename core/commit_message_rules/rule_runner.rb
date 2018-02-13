module CommitMessageRules
  class RuleRunner
    def self.run(rule:, io: Kernel, exiter: Kernel)
      return false unless rule.violated?
      io.puts rule.error_message
      exiter.exit 1 if rule.exit_if_violated?
    end
  end
end
