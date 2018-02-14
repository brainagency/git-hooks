module CommitMessageRules
  class RuleRunner
    def initialize(io: Kernel, exiter: Kernel)
      @io = io
      @exiter = exiter
    end

    def run(rule:)
      return false unless rule.violated?
      io.puts rule.error_message
      exiter.exit 1 if rule.exit_if_violated?
    end

    private

    attr_reader :io, :exiter
  end
end
