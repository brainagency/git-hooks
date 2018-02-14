class CommitMessage
  include Constants

  attr_reader :raw_message

  def initialize(raw_message)
    @raw_message = raw_message.to_s
  end

  def additional_lines_has_description?
    length_of_just_description = additional_lines_joined
      .gsub(ISSUE_REGEX, '')
      .gsub(NO_ISSUE_REGEX, '')
      .chomp.strip.length
    length_of_just_description > LENGTH_OF_DESCRIPTION_THRESHOLD
  end

  def additional_lines_skips_description?
    additional_lines_joined.match NO_DESCRIPTION_REGEX
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

