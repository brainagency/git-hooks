class CommitMessage
  include Constants

  attr_reader :raw_message

  def initialize(raw_message)
    @raw_message = raw_message.to_s
  end

  def main_line
    lines_without_comments[0].to_s
  end

  def additional_lines_joined
    Array(lines_without_comments[1..-1]).join("")
  end

  private

  def lines_without_comments
    @_message_lines_without_comments ||= raw_message
      .split("\n")
      .select { |line| !COMMENT_LINE_REGEX.match(line) }
  end
end

