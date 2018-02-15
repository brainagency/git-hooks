require_relative '../../test_helper'

TestRule = Class.new(CommitMessageRules::BaseRule)

class CommitMessageRules::RuleRunnerTest < Minitest::Test
  def rule
    @rule ||= TestRule.new(commit: mock())
  end

  def test_run_when_not_rule_is_not_violated
    rule.stubs(:violated?).returns(false)
    check_result = CommitMessageRules::RuleRunner.new.run(rule: rule)
    refute check_result.violated?
  end

  def test_run_when_rule_is_violated_without_exit
    rule.stubs(:violated?).returns(true)
    rule.stubs(:error_message).returns('This rule is violated!')
    rule.stubs(:exit_if_violated?).returns(false)


    rule_runner = CommitMessageRules::RuleRunner.new

    check_result = rule_runner.run(rule: rule)

    assert check_result.violated?
    refute check_result.exit_if_violated?
    assert check_result.message == rule.error_message
  end

  def test_run_when_rule_is_violated_with_exit
    rule.stubs(:violated?).returns(true)
    rule.stubs(:error_message).returns('This rule is violated!')
    rule.stubs(:exit_if_violated?).returns(true)

    rule_runner = CommitMessageRules::RuleRunner.new

    check_result = rule_runner.run(rule: rule)

    assert check_result.violated?
    assert check_result.exit_if_violated?
    assert check_result.message == rule.error_message
  end
end
