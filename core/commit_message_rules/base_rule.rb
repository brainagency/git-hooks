require_relative '../constants'

module CommitMessageRules
  class BaseRule
    include Constants

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

    def self.violation_code
      @_violation_code ||= self.name
        .split('::').last
        .gsub(/Rule$/, '')
        .gsub(/([A-Z])/, '_\1').downcase.gsub(/^_/, '')
        .to_sym
    end

    private

    attr_reader :commit
  end
end
