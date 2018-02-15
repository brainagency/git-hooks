require_relative '../../test_helper'

class CommitMessageRules::DefaultCheckingProfileTest < Minitest::Test
  def build_commit(raw_message)
    Commit.new(raw_message: raw_message)
  end

  def test_check_when_commit_message_is_perfect
    commit = build_commit(<<-RAW_MESSAGE
Some pretty short commit description

PRJ-123

Extended and detailed description which explains:
- intentions for the changes
- caveats and workarounds
- breaking changes
- deprecations
                          RAW_MESSAGE
                         )

    check_result = CommitMessageRules::DefaultCheckingProfile.check(commit: commit)

    refute check_result.violated?
  end

  def test_check_when_commit_message_skips_desc_only
    commit = build_commit(<<-RAW_MESSAGE
Commit carriers nothing

PRJ-123 [no-desc]
                          RAW_MESSAGE
                         )

    check_result = CommitMessageRules::DefaultCheckingProfile.check(commit: commit)

    assert check_result.violated?
    refute check_result.exit_if_violated?
    refute check_result.message.empty?
  end

  def test_check_when_commit_message_skips_issue_only
    commit = build_commit(<<-RAW_MESSAGE
Commit carriers nothing

[no-issue]

This commit was made due to some refactoring
                          RAW_MESSAGE
                         )

    check_result = CommitMessageRules::DefaultCheckingProfile.check(commit: commit)

    refute check_result.violated?
  end

  def test_check_when_commit_message_skips_issue_code_and_desc
    commit = build_commit(<<-RAW_MESSAGE
Commit carriers nothing

[no-issue] [no-desc]
                          RAW_MESSAGE
                         )

    check_result = CommitMessageRules::DefaultCheckingProfile.check(commit: commit)

    assert check_result.violated?
    refute check_result.exit_if_violated?
    refute check_result.message.empty?
  end

  def test_check_when_commit_message_main_line_has_issue_code
    commit = build_commit(<<-RAW_MESSAGE
PRJ-123 did something
                          RAW_MESSAGE
                         )

    check_result = CommitMessageRules::DefaultCheckingProfile.check(commit: commit)

    assert check_result.violated?
    assert check_result.exit_if_violated?
    assert_match /^The main line.*contains an issue number.*$/m, check_result.message
  end
end
