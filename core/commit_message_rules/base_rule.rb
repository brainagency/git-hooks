module CommitMessageRules
  class BaseRule
    def initialize(commit:)
      @commit = commit
    end

    def violated?
      raise NotImplementedError
    end
    
    def error_message
      raise NotImplementedError
    end

    def exit_if_violated?
      true
    end

    private

    attr_reader :commit
  end
end
