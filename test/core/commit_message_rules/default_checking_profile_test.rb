require_relative '../../test_helper'

class CommitMessageRules::DefaultCheckingProfileTest < Minitest::Test
  def test_check_runs_proper_number_of_rules
    CommitMessageRules::RuleRunner.any_instance.expects(:run).times(5)
    CommitMessageRules::DefaultCheckingProfile.check(commit: mock())
  end
end
