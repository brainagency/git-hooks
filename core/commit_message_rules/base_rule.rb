require_relative '../constants'

module CommitMessageRules
  class BaseRule
    include Constants

    def self.inherited(child)
      child.const_set('CODE', self.build_violation_code(child.name))
    end

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

    protected

    def self.build_violation_code(class_name)
      @_violation_code ||= class_name
        .split('::').last
        .gsub(/Rule$/, '')
        .gsub(/([A-Z])/, '_\1').downcase.gsub(/^_/, '')
        .to_sym
    end

    private

    attr_reader :commit
  end
end
