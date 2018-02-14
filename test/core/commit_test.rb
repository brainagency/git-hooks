require_relative '../test_helper'

class CommitTest < Minitest::Test
  def mocked_git_proxy
    @_mocked_git_proxy ||= Minitest::Mock.new
  end

  def test_message_provides_wrapped_raw_message
    commit = Commit.new(raw_message: 'Some commit message')

    assert commit.message.is_a?(CommitMessage)
  end
end
