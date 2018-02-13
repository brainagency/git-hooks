require_relative '../../test_helper'

class CommitMessageRules::RuleRunnerTest < Minitest::Test
  def test_run_when_not_rule_is_not_violated
    rule = Minitest::Mock.new
    rule.expect :violated?, false
    refute CommitMessageRules::RuleRunner.run(rule: rule)
  end

  def test_run_when_rule_is_violated_without_exit
    rule = Minitest::Mock.new
    rule.expect :violated?, true
    rule.expect :error_message, 'This rule is violated!'
    rule.expect :exit_if_violated?, false

    exiter = Minitest::Mock.new

    io = Minitest::Mock.new
    io.expect :puts, nil, ['This rule is violated!']

    CommitMessageRules::RuleRunner.run(rule: rule, io: io, exiter: exiter)

    assert_mock rule
    assert_mock io
    assert_mock exiter
  end

  def test_run_when_rule_is_violated_with_exit
    rule = Minitest::Mock.new
    rule.expect :violated?, true
    rule.expect :error_message, 'This rule is violated!'
    rule.expect :exit_if_violated?, true

    exiter = Minitest::Mock.new
    exiter.expect :exit, nil, [1]

    io = Minitest::Mock.new
    io.expect :puts, nil, ['This rule is violated!']

    CommitMessageRules::RuleRunner.run(rule: rule, io: io, exiter: exiter)

    assert_mock rule
    assert_mock io
    assert_mock exiter
  end
end
