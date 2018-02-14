require_relative '../../test_helper'

class CommitMessageRules::DefaultCheckingProfileTest < Minitest::Test
  def mock_io
    @mock_io ||= mock('io')
  end

  def mock_exiter
    @mock_exiter ||= mock('exiter')
  end

  def build_commit(raw_message)
    Commit.new(raw_message: raw_message)
  end

  def test_check_runs_proper_number_of_rules
    CommitMessageRules::RuleRunner.any_instance.expects(:run).times(5)
    CommitMessageRules::DefaultCheckingProfile.check(commit: mock())
  end

  def test_check_when_commit_message_main_line_has_issue_code
    commit = build_commit(<<-RAW_MESSAGE
PRJ-123 did something
                          RAW_MESSAGE
                         )
    mock_exiter.expects(:exit).with(1).at_least(1)
    mock_io.expects(:puts).at_least(1) #.with(regexp_matches(/^The main line.*contains an issue number.*$/m))

    CommitMessageRules::DefaultCheckingProfile.check(
      commit: commit, io: mock_io, exiter: mock_exiter
    )
  end
end
